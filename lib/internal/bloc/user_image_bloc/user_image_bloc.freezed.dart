// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_image_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserImageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() selectAndUploadImage,
    required TResult Function() loadImage,
    required TResult Function() deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? selectAndUploadImage,
    TResult? Function()? loadImage,
    TResult? Function()? deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? selectAndUploadImage,
    TResult Function()? loadImage,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectAndUploadImage value) selectAndUploadImage,
    required TResult Function(_LoadImageEvent value) loadImage,
    required TResult Function(_DeleteImageEvent value) deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult? Function(_LoadImageEvent value)? loadImage,
    TResult? Function(_DeleteImageEvent value)? deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult Function(_LoadImageEvent value)? loadImage,
    TResult Function(_DeleteImageEvent value)? deleteImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserImageEventCopyWith<$Res> {
  factory $UserImageEventCopyWith(
          UserImageEvent value, $Res Function(UserImageEvent) then) =
      _$UserImageEventCopyWithImpl<$Res, UserImageEvent>;
}

/// @nodoc
class _$UserImageEventCopyWithImpl<$Res, $Val extends UserImageEvent>
    implements $UserImageEventCopyWith<$Res> {
  _$UserImageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SelectAndUploadImageImplCopyWith<$Res> {
  factory _$$SelectAndUploadImageImplCopyWith(_$SelectAndUploadImageImpl value,
          $Res Function(_$SelectAndUploadImageImpl) then) =
      __$$SelectAndUploadImageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SelectAndUploadImageImplCopyWithImpl<$Res>
    extends _$UserImageEventCopyWithImpl<$Res, _$SelectAndUploadImageImpl>
    implements _$$SelectAndUploadImageImplCopyWith<$Res> {
  __$$SelectAndUploadImageImplCopyWithImpl(_$SelectAndUploadImageImpl _value,
      $Res Function(_$SelectAndUploadImageImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SelectAndUploadImageImpl implements _SelectAndUploadImage {
  const _$SelectAndUploadImageImpl();

  @override
  String toString() {
    return 'UserImageEvent.selectAndUploadImage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectAndUploadImageImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() selectAndUploadImage,
    required TResult Function() loadImage,
    required TResult Function() deleteImage,
  }) {
    return selectAndUploadImage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? selectAndUploadImage,
    TResult? Function()? loadImage,
    TResult? Function()? deleteImage,
  }) {
    return selectAndUploadImage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? selectAndUploadImage,
    TResult Function()? loadImage,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) {
    if (selectAndUploadImage != null) {
      return selectAndUploadImage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectAndUploadImage value) selectAndUploadImage,
    required TResult Function(_LoadImageEvent value) loadImage,
    required TResult Function(_DeleteImageEvent value) deleteImage,
  }) {
    return selectAndUploadImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult? Function(_LoadImageEvent value)? loadImage,
    TResult? Function(_DeleteImageEvent value)? deleteImage,
  }) {
    return selectAndUploadImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult Function(_LoadImageEvent value)? loadImage,
    TResult Function(_DeleteImageEvent value)? deleteImage,
    required TResult orElse(),
  }) {
    if (selectAndUploadImage != null) {
      return selectAndUploadImage(this);
    }
    return orElse();
  }
}

abstract class _SelectAndUploadImage implements UserImageEvent {
  const factory _SelectAndUploadImage() = _$SelectAndUploadImageImpl;
}

/// @nodoc
abstract class _$$LoadImageEventImplCopyWith<$Res> {
  factory _$$LoadImageEventImplCopyWith(_$LoadImageEventImpl value,
          $Res Function(_$LoadImageEventImpl) then) =
      __$$LoadImageEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImageEventImplCopyWithImpl<$Res>
    extends _$UserImageEventCopyWithImpl<$Res, _$LoadImageEventImpl>
    implements _$$LoadImageEventImplCopyWith<$Res> {
  __$$LoadImageEventImplCopyWithImpl(
      _$LoadImageEventImpl _value, $Res Function(_$LoadImageEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadImageEventImpl implements _LoadImageEvent {
  const _$LoadImageEventImpl();

  @override
  String toString() {
    return 'UserImageEvent.loadImage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImageEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() selectAndUploadImage,
    required TResult Function() loadImage,
    required TResult Function() deleteImage,
  }) {
    return loadImage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? selectAndUploadImage,
    TResult? Function()? loadImage,
    TResult? Function()? deleteImage,
  }) {
    return loadImage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? selectAndUploadImage,
    TResult Function()? loadImage,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) {
    if (loadImage != null) {
      return loadImage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectAndUploadImage value) selectAndUploadImage,
    required TResult Function(_LoadImageEvent value) loadImage,
    required TResult Function(_DeleteImageEvent value) deleteImage,
  }) {
    return loadImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult? Function(_LoadImageEvent value)? loadImage,
    TResult? Function(_DeleteImageEvent value)? deleteImage,
  }) {
    return loadImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult Function(_LoadImageEvent value)? loadImage,
    TResult Function(_DeleteImageEvent value)? deleteImage,
    required TResult orElse(),
  }) {
    if (loadImage != null) {
      return loadImage(this);
    }
    return orElse();
  }
}

abstract class _LoadImageEvent implements UserImageEvent {
  const factory _LoadImageEvent() = _$LoadImageEventImpl;
}

/// @nodoc
abstract class _$$DeleteImageEventImplCopyWith<$Res> {
  factory _$$DeleteImageEventImplCopyWith(_$DeleteImageEventImpl value,
          $Res Function(_$DeleteImageEventImpl) then) =
      __$$DeleteImageEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteImageEventImplCopyWithImpl<$Res>
    extends _$UserImageEventCopyWithImpl<$Res, _$DeleteImageEventImpl>
    implements _$$DeleteImageEventImplCopyWith<$Res> {
  __$$DeleteImageEventImplCopyWithImpl(_$DeleteImageEventImpl _value,
      $Res Function(_$DeleteImageEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeleteImageEventImpl implements _DeleteImageEvent {
  const _$DeleteImageEventImpl();

  @override
  String toString() {
    return 'UserImageEvent.deleteImage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeleteImageEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() selectAndUploadImage,
    required TResult Function() loadImage,
    required TResult Function() deleteImage,
  }) {
    return deleteImage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? selectAndUploadImage,
    TResult? Function()? loadImage,
    TResult? Function()? deleteImage,
  }) {
    return deleteImage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? selectAndUploadImage,
    TResult Function()? loadImage,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) {
    if (deleteImage != null) {
      return deleteImage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectAndUploadImage value) selectAndUploadImage,
    required TResult Function(_LoadImageEvent value) loadImage,
    required TResult Function(_DeleteImageEvent value) deleteImage,
  }) {
    return deleteImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult? Function(_LoadImageEvent value)? loadImage,
    TResult? Function(_DeleteImageEvent value)? deleteImage,
  }) {
    return deleteImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectAndUploadImage value)? selectAndUploadImage,
    TResult Function(_LoadImageEvent value)? loadImage,
    TResult Function(_DeleteImageEvent value)? deleteImage,
    required TResult orElse(),
  }) {
    if (deleteImage != null) {
      return deleteImage(this);
    }
    return orElse();
  }
}

abstract class _DeleteImageEvent implements UserImageEvent {
  const factory _DeleteImageEvent() = _$DeleteImageEventImpl;
}

/// @nodoc
mixin _$UserImageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File image) loadImage,
    required TResult Function(String error) error,
    required TResult Function() deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File image)? loadImage,
    TResult? Function(String error)? error,
    TResult? Function()? deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File image)? loadImage,
    TResult Function(String error)? error,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadImageState value) loadImage,
    required TResult Function(_Error value) error,
    required TResult Function(_DeleteImageState value) deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadImageState value)? loadImage,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeleteImageState value)? deleteImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadImageState value)? loadImage,
    TResult Function(_Error value)? error,
    TResult Function(_DeleteImageState value)? deleteImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserImageStateCopyWith<$Res> {
  factory $UserImageStateCopyWith(
          UserImageState value, $Res Function(UserImageState) then) =
      _$UserImageStateCopyWithImpl<$Res, UserImageState>;
}

/// @nodoc
class _$UserImageStateCopyWithImpl<$Res, $Val extends UserImageState>
    implements $UserImageStateCopyWith<$Res> {
  _$UserImageStateCopyWithImpl(this._value, this._then);

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
    extends _$UserImageStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'UserImageState.initial()';
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
    required TResult Function(File image) loadImage,
    required TResult Function(String error) error,
    required TResult Function() deleteImage,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File image)? loadImage,
    TResult? Function(String error)? error,
    TResult? Function()? deleteImage,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File image)? loadImage,
    TResult Function(String error)? error,
    TResult Function()? deleteImage,
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
    required TResult Function(_LoadImageState value) loadImage,
    required TResult Function(_Error value) error,
    required TResult Function(_DeleteImageState value) deleteImage,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadImageState value)? loadImage,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeleteImageState value)? deleteImage,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadImageState value)? loadImage,
    TResult Function(_Error value)? error,
    TResult Function(_DeleteImageState value)? deleteImage,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserImageState {
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
    extends _$UserImageStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'UserImageState.loading()';
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
    required TResult Function(File image) loadImage,
    required TResult Function(String error) error,
    required TResult Function() deleteImage,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File image)? loadImage,
    TResult? Function(String error)? error,
    TResult? Function()? deleteImage,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File image)? loadImage,
    TResult Function(String error)? error,
    TResult Function()? deleteImage,
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
    required TResult Function(_LoadImageState value) loadImage,
    required TResult Function(_Error value) error,
    required TResult Function(_DeleteImageState value) deleteImage,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadImageState value)? loadImage,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeleteImageState value)? deleteImage,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadImageState value)? loadImage,
    TResult Function(_Error value)? error,
    TResult Function(_DeleteImageState value)? deleteImage,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements UserImageState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadImageStateImplCopyWith<$Res> {
  factory _$$LoadImageStateImplCopyWith(_$LoadImageStateImpl value,
          $Res Function(_$LoadImageStateImpl) then) =
      __$$LoadImageStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({File image});
}

/// @nodoc
class __$$LoadImageStateImplCopyWithImpl<$Res>
    extends _$UserImageStateCopyWithImpl<$Res, _$LoadImageStateImpl>
    implements _$$LoadImageStateImplCopyWith<$Res> {
  __$$LoadImageStateImplCopyWithImpl(
      _$LoadImageStateImpl _value, $Res Function(_$LoadImageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
  }) {
    return _then(_$LoadImageStateImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$LoadImageStateImpl implements _LoadImageState {
  const _$LoadImageStateImpl({required this.image});

  @override
  final File image;

  @override
  String toString() {
    return 'UserImageState.loadImage(image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadImageStateImpl &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadImageStateImplCopyWith<_$LoadImageStateImpl> get copyWith =>
      __$$LoadImageStateImplCopyWithImpl<_$LoadImageStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File image) loadImage,
    required TResult Function(String error) error,
    required TResult Function() deleteImage,
  }) {
    return loadImage(image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File image)? loadImage,
    TResult? Function(String error)? error,
    TResult? Function()? deleteImage,
  }) {
    return loadImage?.call(image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File image)? loadImage,
    TResult Function(String error)? error,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) {
    if (loadImage != null) {
      return loadImage(image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadImageState value) loadImage,
    required TResult Function(_Error value) error,
    required TResult Function(_DeleteImageState value) deleteImage,
  }) {
    return loadImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadImageState value)? loadImage,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeleteImageState value)? deleteImage,
  }) {
    return loadImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadImageState value)? loadImage,
    TResult Function(_Error value)? error,
    TResult Function(_DeleteImageState value)? deleteImage,
    required TResult orElse(),
  }) {
    if (loadImage != null) {
      return loadImage(this);
    }
    return orElse();
  }
}

abstract class _LoadImageState implements UserImageState {
  const factory _LoadImageState({required final File image}) =
      _$LoadImageStateImpl;

  File get image;
  @JsonKey(ignore: true)
  _$$LoadImageStateImplCopyWith<_$LoadImageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$UserImageStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'UserImageState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File image) loadImage,
    required TResult Function(String error) error,
    required TResult Function() deleteImage,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File image)? loadImage,
    TResult? Function(String error)? error,
    TResult? Function()? deleteImage,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File image)? loadImage,
    TResult Function(String error)? error,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadImageState value) loadImage,
    required TResult Function(_Error value) error,
    required TResult Function(_DeleteImageState value) deleteImage,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadImageState value)? loadImage,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeleteImageState value)? deleteImage,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadImageState value)? loadImage,
    TResult Function(_Error value)? error,
    TResult Function(_DeleteImageState value)? deleteImage,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements UserImageState {
  const factory _Error({required final String error}) = _$ErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteImageStateImplCopyWith<$Res> {
  factory _$$DeleteImageStateImplCopyWith(_$DeleteImageStateImpl value,
          $Res Function(_$DeleteImageStateImpl) then) =
      __$$DeleteImageStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteImageStateImplCopyWithImpl<$Res>
    extends _$UserImageStateCopyWithImpl<$Res, _$DeleteImageStateImpl>
    implements _$$DeleteImageStateImplCopyWith<$Res> {
  __$$DeleteImageStateImplCopyWithImpl(_$DeleteImageStateImpl _value,
      $Res Function(_$DeleteImageStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeleteImageStateImpl implements _DeleteImageState {
  const _$DeleteImageStateImpl();

  @override
  String toString() {
    return 'UserImageState.deleteImage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeleteImageStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File image) loadImage,
    required TResult Function(String error) error,
    required TResult Function() deleteImage,
  }) {
    return deleteImage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File image)? loadImage,
    TResult? Function(String error)? error,
    TResult? Function()? deleteImage,
  }) {
    return deleteImage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File image)? loadImage,
    TResult Function(String error)? error,
    TResult Function()? deleteImage,
    required TResult orElse(),
  }) {
    if (deleteImage != null) {
      return deleteImage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadImageState value) loadImage,
    required TResult Function(_Error value) error,
    required TResult Function(_DeleteImageState value) deleteImage,
  }) {
    return deleteImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadImageState value)? loadImage,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeleteImageState value)? deleteImage,
  }) {
    return deleteImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadImageState value)? loadImage,
    TResult Function(_Error value)? error,
    TResult Function(_DeleteImageState value)? deleteImage,
    required TResult orElse(),
  }) {
    if (deleteImage != null) {
      return deleteImage(this);
    }
    return orElse();
  }
}

abstract class _DeleteImageState implements UserImageState {
  const factory _DeleteImageState() = _$DeleteImageStateImpl;
}
