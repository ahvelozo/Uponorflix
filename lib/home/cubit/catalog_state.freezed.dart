// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatalogState {

 CatalogStatus get status; Map<CatalogType, List<VideoViewModel>> get items; List<VideoViewModel> get recent; Map<CatalogType, bool> get reachedMax; String? get errorMessage;
/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogStateCopyWith<CatalogState> get copyWith => _$CatalogStateCopyWithImpl<CatalogState>(this as CatalogState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.recent, recent)&&const DeepCollectionEquality().equals(other.reachedMax, reachedMax)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(recent),const DeepCollectionEquality().hash(reachedMax),errorMessage);

@override
String toString() {
  return 'CatalogState(status: $status, items: $items, recent: $recent, reachedMax: $reachedMax, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CatalogStateCopyWith<$Res>  {
  factory $CatalogStateCopyWith(CatalogState value, $Res Function(CatalogState) _then) = _$CatalogStateCopyWithImpl;
@useResult
$Res call({
 CatalogStatus status, Map<CatalogType, List<VideoViewModel>> items, List<VideoViewModel> recent, Map<CatalogType, bool> reachedMax, String? errorMessage
});




}
/// @nodoc
class _$CatalogStateCopyWithImpl<$Res>
    implements $CatalogStateCopyWith<$Res> {
  _$CatalogStateCopyWithImpl(this._self, this._then);

  final CatalogState _self;
  final $Res Function(CatalogState) _then;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? recent = null,Object? reachedMax = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CatalogStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as Map<CatalogType, List<VideoViewModel>>,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as List<VideoViewModel>,reachedMax: null == reachedMax ? _self.reachedMax : reachedMax // ignore: cast_nullable_to_non_nullable
as Map<CatalogType, bool>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _CatalogState implements CatalogState {
  const _CatalogState({this.status = CatalogStatus.initial, final  Map<CatalogType, List<VideoViewModel>> items = const <CatalogType, List<VideoViewModel>>{}, final  List<VideoViewModel> recent = const <VideoViewModel>[], final  Map<CatalogType, bool> reachedMax = const {}, this.errorMessage}): _items = items,_recent = recent,_reachedMax = reachedMax;
  

@override@JsonKey() final  CatalogStatus status;
 final  Map<CatalogType, List<VideoViewModel>> _items;
@override@JsonKey() Map<CatalogType, List<VideoViewModel>> get items {
  if (_items is EqualUnmodifiableMapView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_items);
}

 final  List<VideoViewModel> _recent;
@override@JsonKey() List<VideoViewModel> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

 final  Map<CatalogType, bool> _reachedMax;
@override@JsonKey() Map<CatalogType, bool> get reachedMax {
  if (_reachedMax is EqualUnmodifiableMapView) return _reachedMax;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reachedMax);
}

@override final  String? errorMessage;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogStateCopyWith<_CatalogState> get copyWith => __$CatalogStateCopyWithImpl<_CatalogState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._recent, _recent)&&const DeepCollectionEquality().equals(other._reachedMax, _reachedMax)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_recent),const DeepCollectionEquality().hash(_reachedMax),errorMessage);

@override
String toString() {
  return 'CatalogState(status: $status, items: $items, recent: $recent, reachedMax: $reachedMax, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CatalogStateCopyWith<$Res> implements $CatalogStateCopyWith<$Res> {
  factory _$CatalogStateCopyWith(_CatalogState value, $Res Function(_CatalogState) _then) = __$CatalogStateCopyWithImpl;
@override @useResult
$Res call({
 CatalogStatus status, Map<CatalogType, List<VideoViewModel>> items, List<VideoViewModel> recent, Map<CatalogType, bool> reachedMax, String? errorMessage
});




}
/// @nodoc
class __$CatalogStateCopyWithImpl<$Res>
    implements _$CatalogStateCopyWith<$Res> {
  __$CatalogStateCopyWithImpl(this._self, this._then);

  final _CatalogState _self;
  final $Res Function(_CatalogState) _then;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? recent = null,Object? reachedMax = null,Object? errorMessage = freezed,}) {
  return _then(_CatalogState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CatalogStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as Map<CatalogType, List<VideoViewModel>>,recent: null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<VideoViewModel>,reachedMax: null == reachedMax ? _self._reachedMax : reachedMax // ignore: cast_nullable_to_non_nullable
as Map<CatalogType, bool>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
