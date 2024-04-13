// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectionDto _$CollectionDtoFromJson(Map<String, dynamic> json) {
  return _CollectionDto.fromJson(json);
}

/// @nodoc
mixin _$CollectionDto {
  String get authorEmail => throw _privateConstructorUsedError;
  String get lowerCaseTitle => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get foodsId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollectionDtoCopyWith<CollectionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionDtoCopyWith<$Res> {
  factory $CollectionDtoCopyWith(
          CollectionDto value, $Res Function(CollectionDto) then) =
      _$CollectionDtoCopyWithImpl<$Res, CollectionDto>;
  @useResult
  $Res call(
      {String authorEmail,
      String lowerCaseTitle,
      String title,
      List<String> foodsId});
}

/// @nodoc
class _$CollectionDtoCopyWithImpl<$Res, $Val extends CollectionDto>
    implements $CollectionDtoCopyWith<$Res> {
  _$CollectionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorEmail = null,
    Object? lowerCaseTitle = null,
    Object? title = null,
    Object? foodsId = null,
  }) {
    return _then(_value.copyWith(
      authorEmail: null == authorEmail
          ? _value.authorEmail
          : authorEmail // ignore: cast_nullable_to_non_nullable
              as String,
      lowerCaseTitle: null == lowerCaseTitle
          ? _value.lowerCaseTitle
          : lowerCaseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      foodsId: null == foodsId
          ? _value.foodsId
          : foodsId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectionDtoImplCopyWith<$Res>
    implements $CollectionDtoCopyWith<$Res> {
  factory _$$CollectionDtoImplCopyWith(
          _$CollectionDtoImpl value, $Res Function(_$CollectionDtoImpl) then) =
      __$$CollectionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String authorEmail,
      String lowerCaseTitle,
      String title,
      List<String> foodsId});
}

/// @nodoc
class __$$CollectionDtoImplCopyWithImpl<$Res>
    extends _$CollectionDtoCopyWithImpl<$Res, _$CollectionDtoImpl>
    implements _$$CollectionDtoImplCopyWith<$Res> {
  __$$CollectionDtoImplCopyWithImpl(
      _$CollectionDtoImpl _value, $Res Function(_$CollectionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorEmail = null,
    Object? lowerCaseTitle = null,
    Object? title = null,
    Object? foodsId = null,
  }) {
    return _then(_$CollectionDtoImpl(
      authorEmail: null == authorEmail
          ? _value.authorEmail
          : authorEmail // ignore: cast_nullable_to_non_nullable
              as String,
      lowerCaseTitle: null == lowerCaseTitle
          ? _value.lowerCaseTitle
          : lowerCaseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      foodsId: null == foodsId
          ? _value._foodsId
          : foodsId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionDtoImpl extends _CollectionDto {
  const _$CollectionDtoImpl(
      {required this.authorEmail,
      required this.lowerCaseTitle,
      required this.title,
      required final List<String> foodsId})
      : _foodsId = foodsId,
        super._();

  factory _$CollectionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionDtoImplFromJson(json);

  @override
  final String authorEmail;
  @override
  final String lowerCaseTitle;
  @override
  final String title;
  final List<String> _foodsId;
  @override
  List<String> get foodsId {
    if (_foodsId is EqualUnmodifiableListView) return _foodsId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodsId);
  }

  @override
  String toString() {
    return 'CollectionDto(authorEmail: $authorEmail, lowerCaseTitle: $lowerCaseTitle, title: $title, foodsId: $foodsId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionDtoImpl &&
            (identical(other.authorEmail, authorEmail) ||
                other.authorEmail == authorEmail) &&
            (identical(other.lowerCaseTitle, lowerCaseTitle) ||
                other.lowerCaseTitle == lowerCaseTitle) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._foodsId, _foodsId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, authorEmail, lowerCaseTitle,
      title, const DeepCollectionEquality().hash(_foodsId));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionDtoImplCopyWith<_$CollectionDtoImpl> get copyWith =>
      __$$CollectionDtoImplCopyWithImpl<_$CollectionDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionDtoImplToJson(
      this,
    );
  }
}

abstract class _CollectionDto extends CollectionDto {
  const factory _CollectionDto(
      {required final String authorEmail,
      required final String lowerCaseTitle,
      required final String title,
      required final List<String> foodsId}) = _$CollectionDtoImpl;
  const _CollectionDto._() : super._();

  factory _CollectionDto.fromJson(Map<String, dynamic> json) =
      _$CollectionDtoImpl.fromJson;

  @override
  String get authorEmail;
  @override
  String get lowerCaseTitle;
  @override
  String get title;
  @override
  List<String> get foodsId;
  @override
  @JsonKey(ignore: true)
  _$$CollectionDtoImplCopyWith<_$CollectionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
