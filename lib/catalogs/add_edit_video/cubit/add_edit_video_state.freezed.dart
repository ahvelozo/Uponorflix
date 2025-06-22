// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_edit_video_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VideoFormState {

 bool get loadData; VideoFormStatus get status; VideoViewModel? get video; String? get thumbnailUrl; String? get error;
/// Create a copy of VideoFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoFormStateCopyWith<VideoFormState> get copyWith => _$VideoFormStateCopyWithImpl<VideoFormState>(this as VideoFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFormState&&(identical(other.loadData, loadData) || other.loadData == loadData)&&(identical(other.status, status) || other.status == status)&&(identical(other.video, video) || other.video == video)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,loadData,status,video,thumbnailUrl,error);

@override
String toString() {
  return 'VideoFormState(loadData: $loadData, status: $status, video: $video, thumbnailUrl: $thumbnailUrl, error: $error)';
}


}

/// @nodoc
abstract mixin class $VideoFormStateCopyWith<$Res>  {
  factory $VideoFormStateCopyWith(VideoFormState value, $Res Function(VideoFormState) _then) = _$VideoFormStateCopyWithImpl;
@useResult
$Res call({
 bool loadData, VideoFormStatus status, VideoViewModel? video, String? thumbnailUrl, String? error
});




}
/// @nodoc
class _$VideoFormStateCopyWithImpl<$Res>
    implements $VideoFormStateCopyWith<$Res> {
  _$VideoFormStateCopyWithImpl(this._self, this._then);

  final VideoFormState _self;
  final $Res Function(VideoFormState) _then;

/// Create a copy of VideoFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadData = null,Object? status = null,Object? video = freezed,Object? thumbnailUrl = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
loadData: null == loadData ? _self.loadData : loadData // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VideoFormStatus,video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as VideoViewModel?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _VideoFormState extends VideoFormState {
  const _VideoFormState({this.loadData = false, this.status = VideoFormStatus.initial, this.video, this.thumbnailUrl, this.error}): super._();
  

@override@JsonKey() final  bool loadData;
@override@JsonKey() final  VideoFormStatus status;
@override final  VideoViewModel? video;
@override final  String? thumbnailUrl;
@override final  String? error;

/// Create a copy of VideoFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoFormStateCopyWith<_VideoFormState> get copyWith => __$VideoFormStateCopyWithImpl<_VideoFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoFormState&&(identical(other.loadData, loadData) || other.loadData == loadData)&&(identical(other.status, status) || other.status == status)&&(identical(other.video, video) || other.video == video)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,loadData,status,video,thumbnailUrl,error);

@override
String toString() {
  return 'VideoFormState(loadData: $loadData, status: $status, video: $video, thumbnailUrl: $thumbnailUrl, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VideoFormStateCopyWith<$Res> implements $VideoFormStateCopyWith<$Res> {
  factory _$VideoFormStateCopyWith(_VideoFormState value, $Res Function(_VideoFormState) _then) = __$VideoFormStateCopyWithImpl;
@override @useResult
$Res call({
 bool loadData, VideoFormStatus status, VideoViewModel? video, String? thumbnailUrl, String? error
});




}
/// @nodoc
class __$VideoFormStateCopyWithImpl<$Res>
    implements _$VideoFormStateCopyWith<$Res> {
  __$VideoFormStateCopyWithImpl(this._self, this._then);

  final _VideoFormState _self;
  final $Res Function(_VideoFormState) _then;

/// Create a copy of VideoFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadData = null,Object? status = null,Object? video = freezed,Object? thumbnailUrl = freezed,Object? error = freezed,}) {
  return _then(_VideoFormState(
loadData: null == loadData ? _self.loadData : loadData // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VideoFormStatus,video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as VideoViewModel?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
