import 'package:uponorflix/catalogs/models/video_view_model.dart';
import 'package:video_local_storage/video_local_storage.dart';

/// Traduce el enum de Hive al enum de presentación.
extension CatalogTypeMapper on CatalogTypeHive {
  CatalogType toCatalogType() => CatalogType.values[index];
}

/// Extensión para convertir colecciones de entidades en view-models.
extension VideoEntityListX on Iterable<VideoEntity> {
  List<VideoViewModel> toViewModels() => map(
    (e) => VideoViewModel(
      id: e.id,
      title: e.title,
      year: e.year,
      thumbnailUrl: e.thumbnailUrl,
      type: e.type.toCatalogType(),
    ),
  ).toList(growable: false);
}
