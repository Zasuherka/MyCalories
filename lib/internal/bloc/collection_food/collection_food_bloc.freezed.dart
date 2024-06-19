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
    required TResult Function(String collectionId) deleteCollection,
    required TResult Function(
            List<Food> updateListFood, Collection collection, String title)
        updateCollection,
    required TResult Function(Collection collection)
        addCollectionInUserListCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(String collectionId)? deleteCollection,
    TResult? Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult? Function(Collection collection)? addCollectionInUserListCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(String collectionId)? deleteCollection,
    TResult Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult Function(Collection collection)? addCollectionInUserListCollection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollection value) getCollection,
    required TResult Function(_DeleteCollection value) deleteCollection,
    required TResult Function(_UpdateCollection value) updateCollection,
    required TResult Function(_AddCollectionInUserListCollection value)
        addCollectionInUserListCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(_DeleteCollection value)? deleteCollection,
    TResult? Function(_UpdateCollection value)? updateCollection,
    TResult? Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(_DeleteCollection value)? deleteCollection,
    TResult Function(_UpdateCollection value)? updateCollection,
    TResult Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
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
    required TResult Function(String collectionId) deleteCollection,
    required TResult Function(
            List<Food> updateListFood, Collection collection, String title)
        updateCollection,
    required TResult Function(Collection collection)
        addCollectionInUserListCollection,
  }) {
    return getCollection(collectionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(String collectionId)? deleteCollection,
    TResult? Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult? Function(Collection collection)? addCollectionInUserListCollection,
  }) {
    return getCollection?.call(collectionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(String collectionId)? deleteCollection,
    TResult Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult Function(Collection collection)? addCollectionInUserListCollection,
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
    required TResult Function(_DeleteCollection value) deleteCollection,
    required TResult Function(_UpdateCollection value) updateCollection,
    required TResult Function(_AddCollectionInUserListCollection value)
        addCollectionInUserListCollection,
  }) {
    return getCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(_DeleteCollection value)? deleteCollection,
    TResult? Function(_UpdateCollection value)? updateCollection,
    TResult? Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
  }) {
    return getCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(_DeleteCollection value)? deleteCollection,
    TResult Function(_UpdateCollection value)? updateCollection,
    TResult Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
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
abstract class _$$DeleteCollectionImplCopyWith<$Res> {
  factory _$$DeleteCollectionImplCopyWith(_$DeleteCollectionImpl value,
          $Res Function(_$DeleteCollectionImpl) then) =
      __$$DeleteCollectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String collectionId});
}

/// @nodoc
class __$$DeleteCollectionImplCopyWithImpl<$Res>
    extends _$CollectionFoodEventCopyWithImpl<$Res, _$DeleteCollectionImpl>
    implements _$$DeleteCollectionImplCopyWith<$Res> {
  __$$DeleteCollectionImplCopyWithImpl(_$DeleteCollectionImpl _value,
      $Res Function(_$DeleteCollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collectionId = null,
  }) {
    return _then(_$DeleteCollectionImpl(
      collectionId: null == collectionId
          ? _value.collectionId
          : collectionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteCollectionImpl implements _DeleteCollection {
  const _$DeleteCollectionImpl({required this.collectionId});

  @override
  final String collectionId;

  @override
  String toString() {
    return 'CollectionFoodEvent.deleteCollection(collectionId: $collectionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCollectionImpl &&
            (identical(other.collectionId, collectionId) ||
                other.collectionId == collectionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, collectionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCollectionImplCopyWith<_$DeleteCollectionImpl> get copyWith =>
      __$$DeleteCollectionImplCopyWithImpl<_$DeleteCollectionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String collectionId) getCollection,
    required TResult Function(String collectionId) deleteCollection,
    required TResult Function(
            List<Food> updateListFood, Collection collection, String title)
        updateCollection,
    required TResult Function(Collection collection)
        addCollectionInUserListCollection,
  }) {
    return deleteCollection(collectionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(String collectionId)? deleteCollection,
    TResult? Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult? Function(Collection collection)? addCollectionInUserListCollection,
  }) {
    return deleteCollection?.call(collectionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(String collectionId)? deleteCollection,
    TResult Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult Function(Collection collection)? addCollectionInUserListCollection,
    required TResult orElse(),
  }) {
    if (deleteCollection != null) {
      return deleteCollection(collectionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollection value) getCollection,
    required TResult Function(_DeleteCollection value) deleteCollection,
    required TResult Function(_UpdateCollection value) updateCollection,
    required TResult Function(_AddCollectionInUserListCollection value)
        addCollectionInUserListCollection,
  }) {
    return deleteCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(_DeleteCollection value)? deleteCollection,
    TResult? Function(_UpdateCollection value)? updateCollection,
    TResult? Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
  }) {
    return deleteCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(_DeleteCollection value)? deleteCollection,
    TResult Function(_UpdateCollection value)? updateCollection,
    TResult Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
    required TResult orElse(),
  }) {
    if (deleteCollection != null) {
      return deleteCollection(this);
    }
    return orElse();
  }
}

abstract class _DeleteCollection implements CollectionFoodEvent {
  const factory _DeleteCollection({required final String collectionId}) =
      _$DeleteCollectionImpl;

  String get collectionId;
  @JsonKey(ignore: true)
  _$$DeleteCollectionImplCopyWith<_$DeleteCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCollectionImplCopyWith<$Res> {
  factory _$$UpdateCollectionImplCopyWith(_$UpdateCollectionImpl value,
          $Res Function(_$UpdateCollectionImpl) then) =
      __$$UpdateCollectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Food> updateListFood, Collection collection, String title});
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
    Object? updateListFood = null,
    Object? collection = null,
    Object? title = null,
  }) {
    return _then(_$UpdateCollectionImpl(
      updateListFood: null == updateListFood
          ? _value._updateListFood
          : updateListFood // ignore: cast_nullable_to_non_nullable
              as List<Food>,
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Collection,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateCollectionImpl implements _UpdateCollection {
  const _$UpdateCollectionImpl(
      {required final List<Food> updateListFood,
      required this.collection,
      required this.title})
      : _updateListFood = updateListFood;

  final List<Food> _updateListFood;
  @override
  List<Food> get updateListFood {
    if (_updateListFood is EqualUnmodifiableListView) return _updateListFood;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updateListFood);
  }

  @override
  final Collection collection;
  @override
  final String title;

  @override
  String toString() {
    return 'CollectionFoodEvent.updateCollection(updateListFood: $updateListFood, collection: $collection, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCollectionImpl &&
            const DeepCollectionEquality()
                .equals(other._updateListFood, _updateListFood) &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_updateListFood), collection, title);

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
    required TResult Function(String collectionId) deleteCollection,
    required TResult Function(
            List<Food> updateListFood, Collection collection, String title)
        updateCollection,
    required TResult Function(Collection collection)
        addCollectionInUserListCollection,
  }) {
    return updateCollection(updateListFood, collection, title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(String collectionId)? deleteCollection,
    TResult? Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult? Function(Collection collection)? addCollectionInUserListCollection,
  }) {
    return updateCollection?.call(updateListFood, collection, title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(String collectionId)? deleteCollection,
    TResult Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult Function(Collection collection)? addCollectionInUserListCollection,
    required TResult orElse(),
  }) {
    if (updateCollection != null) {
      return updateCollection(updateListFood, collection, title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollection value) getCollection,
    required TResult Function(_DeleteCollection value) deleteCollection,
    required TResult Function(_UpdateCollection value) updateCollection,
    required TResult Function(_AddCollectionInUserListCollection value)
        addCollectionInUserListCollection,
  }) {
    return updateCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(_DeleteCollection value)? deleteCollection,
    TResult? Function(_UpdateCollection value)? updateCollection,
    TResult? Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
  }) {
    return updateCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(_DeleteCollection value)? deleteCollection,
    TResult Function(_UpdateCollection value)? updateCollection,
    TResult Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
    required TResult orElse(),
  }) {
    if (updateCollection != null) {
      return updateCollection(this);
    }
    return orElse();
  }
}

abstract class _UpdateCollection implements CollectionFoodEvent {
  const factory _UpdateCollection(
      {required final List<Food> updateListFood,
      required final Collection collection,
      required final String title}) = _$UpdateCollectionImpl;

  List<Food> get updateListFood;
  Collection get collection;
  String get title;
  @JsonKey(ignore: true)
  _$$UpdateCollectionImplCopyWith<_$UpdateCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCollectionInUserListCollectionImplCopyWith<$Res> {
  factory _$$AddCollectionInUserListCollectionImplCopyWith(
          _$AddCollectionInUserListCollectionImpl value,
          $Res Function(_$AddCollectionInUserListCollectionImpl) then) =
      __$$AddCollectionInUserListCollectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Collection collection});
}

/// @nodoc
class __$$AddCollectionInUserListCollectionImplCopyWithImpl<$Res>
    extends _$CollectionFoodEventCopyWithImpl<$Res,
        _$AddCollectionInUserListCollectionImpl>
    implements _$$AddCollectionInUserListCollectionImplCopyWith<$Res> {
  __$$AddCollectionInUserListCollectionImplCopyWithImpl(
      _$AddCollectionInUserListCollectionImpl _value,
      $Res Function(_$AddCollectionInUserListCollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
  }) {
    return _then(_$AddCollectionInUserListCollectionImpl(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Collection,
    ));
  }
}

/// @nodoc

class _$AddCollectionInUserListCollectionImpl
    implements _AddCollectionInUserListCollection {
  const _$AddCollectionInUserListCollectionImpl({required this.collection});

  @override
  final Collection collection;

  @override
  String toString() {
    return 'CollectionFoodEvent.addCollectionInUserListCollection(collection: $collection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCollectionInUserListCollectionImpl &&
            (identical(other.collection, collection) ||
                other.collection == collection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, collection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCollectionInUserListCollectionImplCopyWith<
          _$AddCollectionInUserListCollectionImpl>
      get copyWith => __$$AddCollectionInUserListCollectionImplCopyWithImpl<
          _$AddCollectionInUserListCollectionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String collectionId) getCollection,
    required TResult Function(String collectionId) deleteCollection,
    required TResult Function(
            List<Food> updateListFood, Collection collection, String title)
        updateCollection,
    required TResult Function(Collection collection)
        addCollectionInUserListCollection,
  }) {
    return addCollectionInUserListCollection(collection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String collectionId)? getCollection,
    TResult? Function(String collectionId)? deleteCollection,
    TResult? Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult? Function(Collection collection)? addCollectionInUserListCollection,
  }) {
    return addCollectionInUserListCollection?.call(collection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String collectionId)? getCollection,
    TResult Function(String collectionId)? deleteCollection,
    TResult Function(
            List<Food> updateListFood, Collection collection, String title)?
        updateCollection,
    TResult Function(Collection collection)? addCollectionInUserListCollection,
    required TResult orElse(),
  }) {
    if (addCollectionInUserListCollection != null) {
      return addCollectionInUserListCollection(collection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollection value) getCollection,
    required TResult Function(_DeleteCollection value) deleteCollection,
    required TResult Function(_UpdateCollection value) updateCollection,
    required TResult Function(_AddCollectionInUserListCollection value)
        addCollectionInUserListCollection,
  }) {
    return addCollectionInUserListCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollection value)? getCollection,
    TResult? Function(_DeleteCollection value)? deleteCollection,
    TResult? Function(_UpdateCollection value)? updateCollection,
    TResult? Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
  }) {
    return addCollectionInUserListCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollection value)? getCollection,
    TResult Function(_DeleteCollection value)? deleteCollection,
    TResult Function(_UpdateCollection value)? updateCollection,
    TResult Function(_AddCollectionInUserListCollection value)?
        addCollectionInUserListCollection,
    required TResult orElse(),
  }) {
    if (addCollectionInUserListCollection != null) {
      return addCollectionInUserListCollection(this);
    }
    return orElse();
  }
}

abstract class _AddCollectionInUserListCollection
    implements CollectionFoodEvent {
  const factory _AddCollectionInUserListCollection(
          {required final Collection collection}) =
      _$AddCollectionInUserListCollectionImpl;

  Collection get collection;
  @JsonKey(ignore: true)
  _$$AddCollectionInUserListCollectionImplCopyWith<
          _$AddCollectionInUserListCollectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CollectionFoodState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)
        collection,
    required TResult Function(String errorText) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult? Function(String errorText)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_CollectionFood value) collection,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_CollectionFood value)? collection,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_CollectionFood value)? collection,
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
    required TResult Function() success,
    required TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)
        collection,
    required TResult Function(String errorText) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult? Function(String errorText)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
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
    required TResult Function(_Success value) success,
    required TResult Function(_CollectionFood value) collection,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_CollectionFood value)? collection,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_CollectionFood value)? collection,
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
    required TResult Function() success,
    required TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)
        collection,
    required TResult Function(String errorText) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult? Function(String errorText)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
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
    required TResult Function(_Success value) success,
    required TResult Function(_CollectionFood value) collection,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_CollectionFood value)? collection,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_CollectionFood value)? collection,
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
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$CollectionFoodStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl();

  @override
  String toString() {
    return 'CollectionFoodState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)
        collection,
    required TResult Function(String errorText) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult? Function(String errorText)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_CollectionFood value) collection,
    required TResult Function(_Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_CollectionFood value)? collection,
    TResult? Function(_Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_CollectionFood value)? collection,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements CollectionFoodState {
  const factory _Success() = _$SuccessImpl;
}

/// @nodoc
abstract class _$$CollectionFoodImplCopyWith<$Res> {
  factory _$$CollectionFoodImplCopyWith(_$CollectionFoodImpl value,
          $Res Function(_$CollectionFoodImpl) then) =
      __$$CollectionFoodImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Collection collection,
      bool isUserCollection,
      bool userHaveThisCollection});
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
    Object? collection = null,
    Object? isUserCollection = null,
    Object? userHaveThisCollection = null,
  }) {
    return _then(_$CollectionFoodImpl(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Collection,
      isUserCollection: null == isUserCollection
          ? _value.isUserCollection
          : isUserCollection // ignore: cast_nullable_to_non_nullable
              as bool,
      userHaveThisCollection: null == userHaveThisCollection
          ? _value.userHaveThisCollection
          : userHaveThisCollection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CollectionFoodImpl implements _CollectionFood {
  const _$CollectionFoodImpl(
      {required this.collection,
      required this.isUserCollection,
      required this.userHaveThisCollection});

  @override
  final Collection collection;
  @override
  final bool isUserCollection;
  @override
  final bool userHaveThisCollection;

  @override
  String toString() {
    return 'CollectionFoodState.collection(collection: $collection, isUserCollection: $isUserCollection, userHaveThisCollection: $userHaveThisCollection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionFoodImpl &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            (identical(other.isUserCollection, isUserCollection) ||
                other.isUserCollection == isUserCollection) &&
            (identical(other.userHaveThisCollection, userHaveThisCollection) ||
                other.userHaveThisCollection == userHaveThisCollection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, collection, isUserCollection, userHaveThisCollection);

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
    required TResult Function() success,
    required TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)
        collection,
    required TResult Function(String errorText) failure,
  }) {
    return collection(
        this.collection, isUserCollection, userHaveThisCollection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult? Function(String errorText)? failure,
  }) {
    return collection?.call(
        this.collection, isUserCollection, userHaveThisCollection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult Function(String errorText)? failure,
    required TResult orElse(),
  }) {
    if (collection != null) {
      return collection(
          this.collection, isUserCollection, userHaveThisCollection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_CollectionFood value) collection,
    required TResult Function(_Failure value) failure,
  }) {
    return collection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_CollectionFood value)? collection,
    TResult? Function(_Failure value)? failure,
  }) {
    return collection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_CollectionFood value)? collection,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (collection != null) {
      return collection(this);
    }
    return orElse();
  }
}

abstract class _CollectionFood implements CollectionFoodState {
  const factory _CollectionFood(
      {required final Collection collection,
      required final bool isUserCollection,
      required final bool userHaveThisCollection}) = _$CollectionFoodImpl;

  Collection get collection;
  bool get isUserCollection;
  bool get userHaveThisCollection;
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
    required TResult Function() success,
    required TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)
        collection,
    required TResult Function(String errorText) failure,
  }) {
    return failure(errorText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
    TResult? Function(String errorText)? failure,
  }) {
    return failure?.call(errorText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Collection collection, bool isUserCollection,
            bool userHaveThisCollection)?
        collection,
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
    required TResult Function(_Success value) success,
    required TResult Function(_CollectionFood value) collection,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_CollectionFood value)? collection,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_CollectionFood value)? collection,
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
