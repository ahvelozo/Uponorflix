import 'dart:async';
import 'dart:math';

import 'package:uuid/uuid.dart';
import 'package:video_local_storage/video_local_storage.dart';

/// Repository contract that operates solely with [VideoEntity].
abstract class VideoRepository {
  /// Fetches a page of [VideoEntity] objects.
  ///
  /// [page] is the page number (zero-based).
  /// [limit] is the maximum number of items to return.
  Future<List<VideoEntity>> fetchPage({
    required int page,
    required int limit,
    CatalogTypeHive? filterType,
  });

  /// Inserts or updates a [VideoEntity] in the repository.
  ///
  /// [entity] is the video entity to upsert.
  Future<void> upsert(VideoEntity entity);

  /// Deletes a [VideoEntity] by its [id].
  ///
  /// [id] is the identifier of the video to delete.
  Future<void> delete(String id);

  /// Deletes all videos from the repository.
  ///
  /// This method removes all video entities from the local storage.
  Future<void> deleteAll();

  /// Retrieves a [VideoEntity] by its [id].
  ///
  /// Returns the [VideoEntity] if found, otherwise `null`.
  Future<VideoEntity?> getById(String id);

  /// Seeds the repository with demo data if it is empty.
  ///
  /// [count] is the number of demo videos to insert (default is 50).
  Future<void> seedIfEmpty({int count});
}

/// Implementation of [VideoRepository] using Hive-based local storage.
class HiveVideoRepository implements VideoRepository {
  /// Creates a [HiveVideoRepository] with the given [VideoLocalStorage].

  HiveVideoRepository(this._storage);

  /// The underlying video local storage instance.
  final VideoLocalStorage _storage; // private to keep API surface clean

  /// {@macro VideoRepository.fetchPage}
  @override
  Future<List<VideoEntity>> fetchPage({
    required int page,
    required int limit,
    CatalogTypeHive? filterType,
  }) => _storage.fetchPage(page: page, limit: limit, filterType: filterType);

  /// {@macro VideoRepository.upsert}
  @override
  Future<void> upsert(VideoEntity entity) => _storage.upsert(entity);

  /// {@macro VideoRepository.delete}
  @override
  Future<void> delete(String id) => _storage.delete(id);

  /// {@macro VideoRepository.deleteAll}
  @override
  Future<void> deleteAll() => _storage.deleteAll();

  /// {@macro VideoRepository.getById}
  @override
  Future<VideoEntity?> getById(String id) => _storage.getById(id);

  /// {@macro VideoRepository.seedIfEmpty}
  ///
  /// Seeds the storage with randomly generated demo videos if empty.
  @override
  Future<void> seedIfEmpty({int count = 50}) async {
    if ((await fetchPage(page: 0, limit: 1)).isNotEmpty) return;

    final rnd = Random();
    const uuid = Uuid();
    const titles = [
      'Voyage Beyond',
      'Digital Dreams',
      'Neon City',
      'Lost Horizons',
      'Silent Echoes',
      'Parallel Worlds',
      'Quantum Leap',
      'Midnight Serenade',
      'Pixel Perfect',
      'Gravity Zero',
    ];
    const thumbs = [
      'https://images.unsplash.com/photo-1509395176047-4a66953fd231?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1517602302552-471fe67acf66?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=400&q=80',
    ];
    final years = List.generate(30, (i) => 1995 + i);
    const types = CatalogTypeHive.values;

    for (var i = 0; i < count; i++) {
      await _storage.upsert(
        VideoEntity(
          id: uuid.v4(),
          title: '${titles[rnd.nextInt(titles.length)]} ${i + 1}',
          year: years[rnd.nextInt(years.length)],
          thumbnailUrl: thumbs[rnd.nextInt(thumbs.length)],
          type: types[rnd.nextInt(types.length)],
        ),
      );
    }
  }
}
