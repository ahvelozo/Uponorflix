import 'package:bloc/bloc.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/cubit.dart';
import 'package:uponorflix/catalogs/models/video_mapper_extensions.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

// -----------------------------------------------------------------------------
// Repository contract – delivers paginated view‑models
// -----------------------------------------------------------------------------

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(
    this._repository,
  ) : super(const CatalogState()) {
    _fetchRecent();
    for (final t in CatalogType.values) {
      fetchNextPage(t);
    }
  }

  static const _limit = 20;
  final VideoRepository _repository;
  final Map<CatalogType, int> _pages = {for (var t in CatalogType.values) t: 0};
  final Map<CatalogType, bool> _isFetching = {
    for (var t in CatalogType.values) t: false,
  };

  /*── Recent gallery ─*/
  Future<void> _fetchRecent() async {
    final recentEntities = await _repository.fetchPage(page: 0, limit: 5);
    emit(state.copyWith(recent: recentEntities.toViewModels()));
  }

  /*── Infinite scroll per category ─*/
  Future<void> fetchNextPage(CatalogType type) async {
    if (state.reachedMax[type] == true || _isFetching[type] == true) return;
    _isFetching[type] = true;

    try {
      if (state.status == CatalogStatus.initial) {
        emit(state.copyWith(status: CatalogStatus.loading));
      }

      final page = _pages[type]!;
      final entities = await _repository.fetchPage(
        page: page,
        limit: _limit,
        filterType: type.toHive(),
      );
      final videos = entities.toViewModels();
      _pages[type] = page + 1;

      emit(
        state.copyWith(
          status: CatalogStatus.success,
          items: {
            ...state.items,
            type: [...(state.items[type] ?? []), ...videos],
          },
          reachedMax: {
            ...state.reachedMax,
            type: videos.length < _limit,
          },
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CatalogStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } finally {
      _isFetching[type] = false;
    }
  }

  /*── Refresh all ─*/
  Future<void> refreshAll() async {
    emit(const CatalogState());
    _pages.updateAll((_, __) => 0);
    for (final t in CatalogType.values) {
      await fetchNextPage(t);
    }
  }
}

/*──────────────────────── EXTENSIONS ────────────────────────*/
extension _HiveMap on CatalogType {
  CatalogTypeHive toHive() => CatalogTypeHive.values[index];
}
