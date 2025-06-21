import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:video_local_storage/src/models/video_entity.dart';

/*───────────────────────────────────────────────────────────────────────────*/
/// Hive DAO: opens the box lazily and exposes CRUD + paged fetch.
class VideoLocalStorage {
  /// The name of the Hive box used for storing videos.
  static const _boxName = 'videosBox';

  /// Indicates whether Hive has been initialized.
  static bool _isHiveReady = false;

  /// The Hive box instance for video entities.
  Box<VideoEntity>? _box;

  /// Call once early (e.g. in `main`) before any other method.
  ///
  /// Initializes Hive and registers the necessary adapters.
  static Future<void> init(String path) async {
    if (_isHiveReady) return;

    if (path.isEmpty) {
      await Hive.initFlutter();
    } else {
      Hive.init(path);
    }
    Hive
      ..registerAdapter(CatalogTypeHiveAdapter())
      ..registerAdapter(VideoEntityAdapter());
    _isHiveReady = true;
  }

  /// Opens the Hive box for video entities, if not already open.
  ///
  /// Returns the opened [Box] instance.
  Future<Box<VideoEntity>> _openBox() async {
    if (_box?.isOpen ?? false) return _box!;
    _box = await Hive.openBox<VideoEntity>(_boxName);
    return _box!;
  }

  /*────────────────── CRUD ──────────────────*/

  /// Inserts or updates a [VideoEntity] in the box.
  ///
  /// [entity] is the video entity to upsert.
  Future<void> upsert(VideoEntity entity) async {
    final box = await _openBox();
    await box.put(entity.id, entity);
  }

  /// Deletes a [VideoEntity] from the box by its [id].
  Future<void> delete(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  /// Retrieves a [VideoEntity] by its [id].
  ///
  /// Returns the [VideoEntity] if found, otherwise `null`.
  Future<VideoEntity?> getById(String id) async {
    final box = await _openBox();
    return box.get(id);
  }

  /// Paginated fetch for infinite scrolling; sorted by year DESC then title.
  ///
  /// [page] is the page number (zero-based).
  /// [limit] is the maximum number of items to return.
  /// Returns a list of [VideoEntity] objects for the requested page.
  Future<List<VideoEntity>> fetchPage({
    required int page,
    required int limit,
  }) async {
    final box = await _openBox();
    final start = page * limit;
    return box.values.skip(start).take(limit).toList()..sort((a, b) {
      final byYear = b.year.compareTo(a.year);
      return byYear != 0 ? byYear : a.title.compareTo(b.title);
    });
  }
}
