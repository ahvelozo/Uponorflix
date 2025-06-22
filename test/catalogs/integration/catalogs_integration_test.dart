// ignore_for_file: avoid_catches_without_on_clauses, document_ignores

import 'package:flutter_test/flutter_test.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/catalog_cubit.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class FakeVideoRepository implements VideoRepository {
  final List<VideoEntity> _videos = [];

  @override
  Future<List<VideoEntity>> fetchPage({
    required int page,
    required int limit,
    CatalogTypeHive? filterType,
  }) async {
    return _videos.skip(page * limit).take(limit).toList();
  }

  @override
  Future<void> upsert(VideoEntity entity) async {
    _videos
      ..removeWhere((v) => v.id == entity.id)
      ..add(entity);
  }

  @override
  Future<void> delete(String id) async {
    _videos.removeWhere((v) => v.id == id);
  }

  @override
  Future<void> deleteAll() async {
    _videos.clear();
  }

  @override
  Future<VideoEntity?> getById(String id) async {
    try {
      return _videos.firstWhere((v) => v.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> seedIfEmpty({int count = 50}) async {}
}

void main() {
  group('Catalogs Integration', () {
    late CatalogCubit cubit;
    late FakeVideoRepository repo;

    setUp(() {
      repo = FakeVideoRepository();
      cubit = CatalogCubit(repo);
    });

    test('Insert and list a video', () async {
      final initialCount = cubit.state.videos.length;
      final video = VideoEntity(
        id: '1',
        title: 'Test Video',
        year: 2024,
        thumbnailUrl: 'https://test.com/thumb.jpg',
        type: CatalogTypeHive.movie,
      );
      await repo.upsert(video);
      await cubit.refresh();
      expect(cubit.state.videos.length, initialCount + 1);
      expect(cubit.state.videos.last.title, 'Test Video');
    });

    test('Edit a video updates its data', () async {
      // 1. Insertamos un vídeo inicial
      final video = VideoEntity(
        id: '3',
        title: 'Original Title',
        year: 2024,
        thumbnailUrl: 'https://test.com/original.jpg',
        type: CatalogTypeHive.movie,
      );
      await repo.upsert(video);
      await cubit.refresh();

      // 2. Editamos (upsert otra vez con el mismo id pero datos distintos)
      final editedVideo = VideoEntity(
        id: '3',
        title: 'Edited Title',
        year: 2024,
        thumbnailUrl: 'https://test.com/edited.jpg',
        type: CatalogTypeHive.movie,
      );
      await repo.upsert(editedVideo);
      await cubit.refresh();

      // 3. Asertamos que el cambio se refleja en el estado
      final updated = cubit.state.videos.firstWhere(
        (v) => v.id == editedVideo.id,
      );
      expect(updated.title, 'Edited Title');
      expect(updated.thumbnailUrl, 'https://test.com/edited.jpg');
    });

    test('Delete a video and check count', () async {
      final video = VideoEntity(
        id: '2',
        title: 'Delete Me',
        year: 2024,
        thumbnailUrl: 'https://test.com/thumb2.jpg',
        type: CatalogTypeHive.series,
      );
      await repo.upsert(video);
      await cubit.refresh();
      final countBefore = cubit.state.videos.length;
      await cubit.deleteVideo(video.id);
      expect(cubit.state.videos.length, countBefore - 1);
      expect(cubit.state.videos.where((v) => v.id == video.id).isEmpty, true);
    });
  });
}
