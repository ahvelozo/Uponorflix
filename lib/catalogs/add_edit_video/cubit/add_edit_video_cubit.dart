import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/catalogs/add_edit_video/cubit/cubit.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';
import 'package:uuid/uuid.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class VideoFormCubit extends Cubit<VideoFormState> {
  VideoFormCubit({required this.repo, required String? videoId})
    : super(const VideoFormState()) {
    _load(videoId);
  }

  final VideoRepository repo;

  CatalogType _fromHive(CatalogTypeHive h) => CatalogType.values[h.index];
  CatalogTypeHive _toHive(CatalogType t) => CatalogTypeHive.values[t.index];

  Future<void> _load(String? id) async {
    if (id == null) return;
    emit(state.copyWith(status: VideoFormStatus.loading));
    try {
      final entity = await repo.getById(id);
      if (entity != null) {
        emit(
          state.copyWith(
            status: VideoFormStatus.success,
            video: VideoViewModel(
              id: entity.id,
              title: entity.title,
              year: entity.year,
              thumbnailUrl: entity.thumbnailUrl,
              type: _fromHive(entity.type),
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(status: VideoFormStatus.failure, error: 'Not found'),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(status: VideoFormStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> save(VideoViewModel view) async {
    emit(state.copyWith(status: VideoFormStatus.loading));
    final entity = VideoEntity(
      id: view.id.isEmpty ? const Uuid().v4() : view.id,
      title: view.title,
      year: view.year,
      thumbnailUrl: view.thumbnailUrl,
      type: _toHive(view.type),
    );
    try {
      await repo.upsert(entity);
      emit(
        state.copyWith(
          status: VideoFormStatus.success,
          // video: view.copyWith(id: entity.id),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(status: VideoFormStatus.failure, error: e.toString()),
      );
    }
  }
}
