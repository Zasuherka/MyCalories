// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_food_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CollectionFoodEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String collectionId) getCollection,
    required TResult Function(List<String> listFoodsId) updateCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(List<String> listFoodsId)? updateCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(List<String> listFoodsId)? updateCollection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollection value) getCollection,
    required TResult Function(UpdateCollection value) updateCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(UpdateCollection value)? updateCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(UpdateCollection value)? updateCollection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionFoodEventCopyWith<$Res> {
  factory $CollectionFoodEventCopyWith(
          CollectionFoodEvent value, $Res Function(CollectionFoodEvent) then) =
      _$CollectionFoodEventCopyWithImpl<$Res, CollectionFoodEvent>;
}

/// @nodoc
class _$CollectionFoodEventCopyWithImpl<$Res, $Val extends CollectionFoodEvent>
    implements $CollectionFoodEventCopyWith<$Res> {
  _$CollectionFoodEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetCollectionImplCopyWith<$Res> {
  factory _$$GetCollectionImplCopyWith(
          _$GetCollectionImpl value, $Res Function(_$GetCollectionImpl) then) =
      __$$GetCollectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String collectionId});
}

/// @nodoc
class __$$GetCollectionImplCopyWithImpl<$Res>
    extends _$CollectionFoodEventCopyWithImpl<$Res, _$GetCollectionImpl>
    implements _$$GetCollectionImplCopyWith<$Res> {
  __$$GetCollectionImplCopyWithImpl(
      _$GetCollectionImpl _value, $Res Function(_$GetCollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collectionId = null,
  }) {
    return _then(_$GetCollectionImpl(
      collectionId: null == collectionId
          ? _value.collectionId
          : collectionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetCollectionImpl implements _GetCollection {
  const _$GetCollectionImpl({required this.collectionId});

  @override
  final String collectionId;

  @override
  String toString() {
    return 'CollectionFoodEvent.getCollection(collectionId: $collectionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCollectionImpl &&
            (identical(other.collectionId, collectionId) ||
                other.collectionId == collectionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, collectionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCollectionImplCopyWith<_$GetCollectionImpl> get copyWith =>
      __$$GetCollectionImplCopyWithImpl<_$GetCollectionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String collectionId) getCollection,
    required TResult Function(List<String> listFoodsId) updateCollection,
  }) {
    return getCollection(collectionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(List<String> listFoodsId)? updateCollection,
  }) {
    return getCollection?.call(collectionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(List<String> listFoodsId)? updateCollection,
    required TResult orElse(),
  }) {
    if (getCollection != null) {
      return getCollection(collectionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollection value) getCollection,
    required TResult Function(UpdateCollection value) updateCollection,
  }) {
    return getCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(UpdateCollection value)? updateCollection,
  }) {
    return getCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(UpdateCollection value)? updateCollection,
    required TResult orElse(),
  }) {
    if (getCollection != null) {
      return getCollection(this);
    }
    return orElse();
  }
}

abstract class _GetCollection implements CollectionFoodEvent {
  const factory _GetCollection({required final String collectionId}) =
      _$GetCollectionImpl;

  String get collectionId;
  @JsonKey(ignore: true)
  _$$GetCollectionImplCopyWith<_$GetCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCollectionImplCopyWith<$Res> {
  factory _$$UpdateCollectionImplCopyWith(_$UpdateCollectionImpl value,
          $Res Function(_$UpdateCollectionImpl) then) =
      __$$UpdateCollectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> listFoodsId});
}

/// @nodoc
class __$$UpdateCollectionImplCopyWithImpl<$Res>
    extends _$CollectionFoodEventCopyWithImpl<$Res, _$UpdateCollectionImpl>
    implements _$$UpdateCollectionImplCopyWith<$Res> {
  __$$UpdateCollectionImplCopyWithImpl(_$UpdateCollectionImpl _value,
      $Res Function(_$UpdateCollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listFoodsId = null,
  }) {
    return _then(_$UpdateCollectionImpl(
      listFoodsId: null == listFoodsId
          ? _value._listFoodsId
          : listFoodsId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$UpdateCollectionImpl implements UpdateCollection {
  const _$UpdateCollectionImpl({required final List<String> listFoodsId})
      : _listFoodsId = listFoodsId;

  final List<String> _listFoodsId;
  @override
  List<String> get listFoodsId {
    if (_listFoodsId is EqualUnmodifiableListView) return _listFoodsId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listFoodsId);
  }

  @override
  String toString() {
    return 'CollectionFoodEvent.updateCollection(listFoodsId: $listFoodsId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCollectionImpl &&
            const DeepCollectionEquality()
                .equals(other._listFoodsId, _listFoodsId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_listFoodsId));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCollectionImplCopyWith<_$UpdateCollectionImpl> get copyWith =>
      __$$UpdateCollectionImplCopyWithImpl<_$UpdateCollectionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String collectionId) getCollection,
    required TResult Function(List<String> listFoodsId) updateCollection,
  }) {
    return updateCollection(listFoodsId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(List<String> listFoodsId)? updateCollection,
  }) {
    return updateCollection?.call(listFoodsId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(List<String> listFoodsId)? updateCollection,
    required TResult orElse(),
  }) {
    if (updateCollection != null) {
      return updateCollection(listFoodsId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollection value) getCollection,
    required TResult Function(UpdateCollection value) updateCollection,
  }) {
    return updateCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(UpdateCollection value)? updateCollection,
  }) {
    return updateCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(UpdateCollection value)? updateCollection,
    required TResult orElse(),
  }) {
    if (updateCollection != null) {
      return updateCollection(this);
    }
    return orElse();
  }
}

abstract class UpdateCollection implements CollectionFoodEvent {
  const factory UpdateCollection({required final List<String> listFoodsId}) =
      _$UpdateCollectionImpl;

  List<String> get listFoodsId;
  @JsonKey(ignore: true)
  _$$UpdateCollectionImplCopyWith<_$UpdateCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CollectionFoodState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Food> list) collectionFood,
    required TResult Function(String errorText) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Food> list)? collectionFood,
    TResult? Function(String errorText)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Food> list)? collectionFood,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_CollectionFood value) collectionFood,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CollectionFood value)? collectionFood,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_CollectionFood value)? collectionFood,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionFoodStateCopyWith<$Res> {
  factory $CollectionFoodStateCopyWith(
          CollectionFoodState value, $Res Function(CollectionFoodState) then) =
      _$CollectionFoodStateCopyWithImpl<$Res, CollectionFoodState>;
}

/// @nodoc
class _$CollectionFoodStateCopyWithImpl<$Res, $Val extends CollectionFoodState>
    implements $CollectionFoodStateCopyWith<$Res> {
  _$CollectionFoodStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CollectionFoodStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CollectionFoodState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Food> list) collectionFood,
    required TResult Function(String errorText) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Food> list)? collectionFood,
    TResult? Function(String errorText)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Food> list)? collectionFood,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_CollectionFood value) collectionFood,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CollectionFood value)? collectionFood,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_CollectionFood value)? collectionFood,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CollectionFoodState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CollectionFoodStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CollectionFoodState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Food> list) collectionFood,
    required TResult Function(String errorText) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Food> list)? collectionFood,
    TResult? Function(String errorText)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Food> list)? collectionFood,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_CollectionFood value) collectionFood,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CollectionFood value)? collectionFood,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_CollectionFood value)? collectionFood,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CollectionFoodState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$CollectionFoodImplCopyWith<$Res> {
  factory _$$CollectionFoodImplCopyWith(_$CollectionFoodImpl value,
          $Res Function(_$CollectionFoodImpl) then) =
      __$$CollectionFoodImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Food> list});
}

/// @nodoc
class __$$CollectionFoodImplCopyWithImpl<$Res>
    extends _$CollectionFoodStateCopyWithImpl<$Res, _$CollectionFoodImpl>
    implements _$$CollectionFoodImplCopyWith<$Res> {
  __$$CollectionFoodImplCopyWithImpl(
      _$CollectionFoodImpl _value, $Res Function(_$CollectionFoodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$CollectionFoodImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Food>,
    ));
  }
}

/// @nodoc

class _$CollectionFoodImpl implements _CollectionFood {
  const _$CollectionFoodImpl({required final List<Food> list}) : _list = list;

  final List<Food> _list;
  @override
  List<Food> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'CollectionFoodState.collectionFood(list: $list)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionFoodImpl &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionFoodImplCopyWith<_$CollectionFoodImpl> get copyWith =>
      __$$CollectionFoodImplCopyWithImpl<_$CollectionFoodImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Food> list) collectionFood,
    required TResult Function(String errorText) failure,
  }) {
    return collectionFood(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Food> list)? collectionFood,
    TResult? Function(String errorText)? failure,
  }) {
    return collectionFood?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Food> list)? collectionFood,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) {
    if (collectionFood != null) {
      return collectionFood(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_CollectionFood value) collectionFood,
    required TResult Function(_Failure value) failure,
  }) {
    return collectionFood(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CollectionFood value)? collectionFood,
    TResult? Function(_Failure value)? failure,
  }) {
    return collectionFood?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_CollectionFood value)? collectionFood,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (collectionFood != null) {
      return collectionFood(this);
    }
    return orElse();
  }
}

abstract class _CollectionFood implements CollectionFoodState {
  const factory _CollectionFood({required final List<Food> list}) =
      _$CollectionFoodImpl;

  List<Food> get list;
  @JsonKey(ignore: true)
  _$$CollectionFoodImplCopyWith<_$CollectionFoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorText});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$CollectionFoodStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorText = null,
  }) {
    return _then(_$FailureImpl(
      errorText: null == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl({required this.errorText});

  @override
  final String errorText;

  @override
  String toString() {
    return 'CollectionFoodState.failure(errorText: $errorText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Food> list) collectionFood,
    required TResult Function(String errorText) failure,
  }) {
    return failure(errorText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Food> list)? collectionFood,
    TResult? Function(String errorText)? failure,
  }) {
    return failure?.call(errorText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Food> list)? collectionFood,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_CollectionFood value) collectionFood,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CollectionFood value)? collectionFood,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_CollectionFood value)? collectionFood,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements CollectionFoodState {
  const factory _Failure({required final String errorText}) = _$FailureImpl;

  String get errorText;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
