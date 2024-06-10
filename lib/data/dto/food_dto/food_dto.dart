import 'package:app1/domain/models/food.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_dto.freezed.dart';
part 'food_dto.g.dart';

@freezed
class FoodDto with _$FoodDto {
  const FoodDto._();
  const factory FoodDto({
    required String idFood,
    required String title,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String calories,
    required String authorEmail
  }) = _FoodDto;

  factory FoodDto.fromJson(Map<String, dynamic> json) => _$FoodDtoFromJson(json);

  Food toFood() => Food(
      idFood,
      authorEmail,
      title,
      double.tryParse(protein) ?? 0,
      double.tryParse(fats) ?? 0,
      double.tryParse(carbohydrates) ?? 0,
      double.tryParse(calories) ?? 0,
  );
}