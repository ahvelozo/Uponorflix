// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/cubit.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

// -----------------------------------------------------------------------------
// Repository contract – delivers paginated view‑models
// -----------------------------------------------------------------------------

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._repository) : super(const CatalogState()) {
    fetchNextPage();
  }

  static const _limit = 20;
  final VideoRepository _repository;
  int _page = 0;
  bool _isFetching = false;

  Future<void> fetchNextPage() async {
    if (state.hasReachedMax || _isFetching) return;
    _isFetching = true;

    try {
      if (state.status == CatalogStatus.initial) {
        emit(state.copyWith(status: CatalogStatus.loading));
      }

      final videos = await _repository.fetchPage(page: _page, limit: _limit);
      _page++;

      emit(
        videos.isEmpty
            ? state.copyWith(
                status: CatalogStatus.success,
                hasReachedMax: true,
              )
            : state.copyWith(
                status: CatalogStatus.success,
                videos: [...state.videos, ...videos],
                hasReachedMax: videos.length < _limit,
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CatalogStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    _page = 0;
    emit(const CatalogState());
    await fetchNextPage();
  }

  Future<void> deleteVideo(String id) async {
    await _repository.delete(id);
    emit(
      state.copyWith(videos: state.videos.where((v) => v.id != id).toList()),
    );
  }
}
