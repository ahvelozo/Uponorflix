import 'package:equatable/equatable.dart';

// -----------------------------------------------------------------------------
// Types
// -----------------------------------------------------------------------------
/// Categorises the video so the UI can render badges or filters.
enum CatalogType { movie, series, clip, other }

// -----------------------------------------------------------------------------
// View Model (used only for rendering content in the UI layer)
// -----------------------------------------------------------------------------
class VideoViewModel extends Equatable {
  const VideoViewModel({
    required this.id,
    required this.title,
    required this.year,
    required this.thumbnailUrl,
    required this.type,
  });

  final String id;
  final String title;
  final int year;
  final String thumbnailUrl;
  final CatalogType type;

  @override
  List<Object?> get props => [id, title, year, thumbnailUrl, type];
}
