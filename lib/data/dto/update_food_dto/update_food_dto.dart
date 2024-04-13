import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_food_dto.freezed.dart';
part 'update_food_dto.g.dart';

@freezed
class UpdateFoodDto with _$UpdateFoodDto {

  const UpdateFoodDto._();
  const factory UpdateFoodDto({
    required String title,
    required String lowerCaseTitle,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String calories,
    required String authorEmail
  }) = _UpdateFoodDto;

  factory UpdateFoodDto.fromJson(Map<String, dynamic> json) => _$UpdateFoodDtoFromJson(json);
}