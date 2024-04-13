import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_dto.freezed.dart';
part 'food_dto.g.dart';

@freezed
class FoodDto with _$FoodDto {

  const FoodDto._();
  const factory FoodDto({
    required String title,
    required String lowerCaseTitle,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String calories,
    required String authorEmail
  }) = _FoodDto;

  factory FoodDto.fromJson(Map<String, dynamic> json) => _$FoodDtoFromJson(json);
}