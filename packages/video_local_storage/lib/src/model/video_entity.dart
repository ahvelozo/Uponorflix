// -----------------------------------------------------------------------------
// Hive types
// -----------------------------------------------------------------------------
import 'package:hive/hive.dart';

part 'video_entity.g.dart'; // ⇢ run build_runner to generate

@HiveType(typeId: 1)
enum CatalogTypeHive {
  @HiveField(0)
  movie,
  @HiveField(1)
  series,
  @HiveField(2)
  clip,
  @HiveField(3)
  other,
}

/// Persistent representation of a video (no JSON helpers).
@HiveType(typeId: 2)
class VideoEntity extends HiveObject {
  VideoEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.thumbnailUrl,
    required this.type,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int year;

  @HiveField(3)
  String thumbnailUrl;

  @HiveField(4)
  CatalogTypeHive type;
}
