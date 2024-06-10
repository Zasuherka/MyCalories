// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateFoodDto _$CreateFoodDtoFromJson(Map<String, dynamic> json) {
  return _FoodDto.fromJson(json);
}

/// @nodoc
mixin _$CreateFoodDto {
  String get title => throw _privateConstructorUsedError;
  String get lowerCaseTitle => throw _privateConstructorUsedError;
  String get protein => throw _privateConstructorUsedError;
  String get fats => throw _privateConstructorUsedError;
  String get carbohydrates => throw _privateConstructorUsedError;
  String get calories => throw _privateConstructorUsedError;
  String get authorEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateFoodDtoCopyWith<CreateFoodDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateFoodDtoCopyWith<$Res> {
  factory $CreateFoodDtoCopyWith(
          CreateFoodDto value, $Res Function(CreateFoodDto) then) =
      _$CreateFoodDtoCopyWithImpl<$Res, CreateFoodDto>;
  @useResult
  $Res call(
      {String title,
      String lowerCaseTitle,
      String protein,
      String fats,
      String carbohydrates,
      String calories,
      String authorEmail});
}

/// @nodoc
class _$CreateFoodDtoCopyWithImpl<$Res, $Val extends CreateFoodDto>
    implements $CreateFoodDtoCopyWith<$Res> {
  _$CreateFoodDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? lowerCaseTitle = null,
    Object? protein = null,
    Object? fats = null,
    Object? carbohydrates = null,
    Object? calories = null,
    Object? authorEmail = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lowerCaseTitle: null == lowerCaseTitle
          ? _value.lowerCaseTitle
          : lowerCaseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as String,
      fats: null == fats
          ? _value.fats
          : fats // ignore: cast_nullable_to_non_nullable
              as String,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as String,
      authorEmail: null == authorEmail
          ? _value.authorEmail
          : authorEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodDtoImplCopyWith<$Res>
    implements $CreateFoodDtoCopyWith<$Res> {
  factory _$$FoodDtoImplCopyWith(
          _$FoodDtoImpl value, $Res Function(_$FoodDtoImpl) then) =
      __$$FoodDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String lowerCaseTitle,
      String protein,
      String fats,
      String carbohydrates,
      String calories,
      String authorEmail});
}

/// @nodoc
class __$$FoodDtoImplCopyWithImpl<$Res>
    extends _$CreateFoodDtoCopyWithImpl<$Res, _$FoodDtoImpl>
    implements _$$FoodDtoImplCopyWith<$Res> {
  __$$FoodDtoImplCopyWithImpl(
      _$FoodDtoImpl _value, $Res Function(_$FoodDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? lowerCaseTitle = null,
    Object? protein = null,
    Object? fats = null,
    Object? carbohydrates = null,
    Object? calories = null,
    Object? authorEmail = null,
  }) {
    return _then(_$FoodDtoImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lowerCaseTitle: null == lowerCaseTitle
          ? _value.lowerCaseTitle
          : lowerCaseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as String,
      fats: null == fats
          ? _value.fats
          : fats // ignore: cast_nullable_to_non_nullable
              as String,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as String,
      authorEmail: null == authorEmail
          ? _value.authorEmail
          : authorEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodDtoImpl extends _FoodDto {
  const _$FoodDtoImpl(
      {required this.title,
      required this.lowerCaseTitle,
      required this.protein,
      required this.fats,
      required this.carbohydrates,
      required this.calories,
      required this.authorEmail})
      : super._();

  factory _$FoodDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodDtoImplFromJson(json);

  @override
  final String title;
  @override
  final String lowerCaseTitle;
  @override
  final String protein;
  @override
  final String fats;
  @override
  final String carbohydrates;
  @override
  final String calories;
  @override
  final String authorEmail;

  @override
  String toString() {
    return 'CreateFoodDto(title: $title, lowerCaseTitle: $lowerCaseTitle, protein: $protein, fats: $fats, carbohydrates: $carbohydrates, calories: $calories, authorEmail: $authorEmail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lowerCaseTitle, lowerCaseTitle) ||
                other.lowerCaseTitle == lowerCaseTitle) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.fats, fats) || other.fats == fats) &&
            (identical(other.carbohydrates, carbohydrates) ||
                other.carbohydrates == carbohydrates) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.authorEmail, authorEmail) ||
                other.authorEmail == authorEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, lowerCaseTitle, protein,
      fats, carbohydrates, calories, authorEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDtoImplCopyWith<_$FoodDtoImpl> get copyWith =>
      __$$FoodDtoImplCopyWithImpl<_$FoodDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodDtoImplToJson(
      this,
    );
  }
}

abstract class _FoodDto extends CreateFoodDto {
  const factory _FoodDto(
      {required final String title,
      required final String lowerCaseTitle,
      required final String protein,
      required final String fats,
      required final String carbohydrates,
      required final String calories,
      required final String authorEmail}) = _$FoodDtoImpl;
  const _FoodDto._() : super._();

  factory _FoodDto.fromJson(Map<String, dynamic> json) = _$FoodDtoImpl.fromJson;

  @override
  String get title;
  @override
  String get lowerCaseTitle;
  @override
  String get protein;
  @override
  String get fats;
  @override
  String get carbohydrates;
  @override
  String get calories;
  @override
  String get authorEmail;
  @override
  @JsonKey(ignore: true)
  _$$FoodDtoImplCopyWith<_$FoodDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
