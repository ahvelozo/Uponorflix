import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

part 'add_edit_video_state.freezed.dart';

@freezed
class VideoFormState with _$VideoFormState {
  const factory VideoFormState({
    @Default(VideoFormStatus.initial) VideoFormStatus status,
    VideoViewModel? video,
    String? error,
  }) = _VideoFormState;
  const VideoFormState._();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

enum VideoFormStatus { initial, loading, success, failure }
