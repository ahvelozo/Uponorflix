// -----------------------------------------------------------------------------
// Hive types
// -----------------------------------------------------------------------------
import 'package:hive/hive.dart';

part 'video_entity.g.dart'; // ⇢ run build_runner to generate

/// Enum representing catalog types for videos stored in Hive.
@HiveType(typeId: 1)
enum CatalogTypeHive {
  /// Movie
  @HiveField(0)
  movie,

  /// Series
  @HiveField(1)
  series,

  /// Short clip
  @HiveField(2)
  clip,

  /// Other type of video
  @HiveField(3)
  other,
}

/// Persistent representation of a video for local storage with Hive.
///
/// Does not include JSON helpers.
@HiveType(typeId: 2)
class VideoEntity extends HiveObject {
  /// Creates a new instance of [VideoEntity].
  ///
  /// [id] unique identifier of the video.
  /// [title] title of the video.
  /// [year] year of release.
  /// [thumbnailUrl] thumbnail URL.
  /// [type] catalog type of the video.
  /// [createdAt] creation date of the video entity.
  VideoEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.thumbnailUrl,
    required this.type,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Unique identifier of the video.
  @HiveField(0)
  String id;

  /// Title of the video.
  @HiveField(1)
  String title;

  /// Year of release of the video.
  @HiveField(2)
  int year;

  /// Thumbnail URL of the video.
  @HiveField(3)
  String thumbnailUrl;

  /// Catalog type of the video.
  @HiveField(4)
  CatalogTypeHive type;

  /// Creation date of the video entity.
  @HiveField(5)
  DateTime createdAt;
}
