import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:video_local_storage/src/models/video_entity.dart';

/*───────────────────────────────────────────────────────────────────────────*/
/// Hive DAO: opens the box lazily and exposes CRUD + paged fetch.
class VideoLocalStorage {
  static const _boxName = 'videosBox';
  static bool _isHiveReady = false;
  Box<VideoEntity>? _box;

  /// Call once early (e.g. in `main`) before any other method.
  static Future<void> init() async {
    if (_isHiveReady) return;
    final dir = await path_provider.getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(CatalogTypeHiveAdapter())
      ..registerAdapter(VideoEntityAdapter());
    _isHiveReady = true;
  }

  Future<Box<VideoEntity>> _openBox() async {
    if (_box?.isOpen ?? false) return _box!;
    _box = await Hive.openBox<VideoEntity>(_boxName);
    return _box!;
  }

  /*────────────────── CRUD ──────────────────*/
  Future<void> upsert(VideoEntity entity) async {
    final box = await _openBox();
    await box.put(entity.id, entity);
  }

  Future<void> delete(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  Future<VideoEntity?> getById(String id) async {
    final box = await _openBox();
    return box.get(id);
  }

  /// Paginated fetch for infinite scrolling; sorted by year DESC then title.
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
