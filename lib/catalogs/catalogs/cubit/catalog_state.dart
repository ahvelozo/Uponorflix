import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

part 'catalog_state.freezed.dart';

enum CatalogStatus { initial, loading, success, failure }

@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState({
    @Default(CatalogStatus.initial) CatalogStatus status,
    @Default(<VideoViewModel>[]) List<VideoViewModel> videos,
    @Default(false) bool hasReachedMax,
    String? errorMessage,
  }) = _CatalogState;

  @override
  // TODO: implement errorMessage
  String? get errorMessage => throw UnimplementedError();

  @override
  // TODO: implement hasReachedMax
  bool get hasReachedMax => throw UnimplementedError();

  @override
  // TODO: implement status
  CatalogStatus get status => throw UnimplementedError();

  @override
  // TODO: implement videos
  List<VideoViewModel> get videos => throw UnimplementedError();
}
