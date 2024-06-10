import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_food_dto.freezed.dart';
part 'create_food_dto.g.dart';

@freezed
class CreateFoodDto with _$CreateFoodDto {

  const CreateFoodDto._();
  const factory CreateFoodDto({
    required String title,
    required String lowerCaseTitle,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String calories,
    required String authorEmail
  }) = _FoodDto;

  factory CreateFoodDto.fromJson(Map<String, dynamic> json) => _$CreateFoodDtoFromJson(json);
}