part of 'food_bloc.dart';

@freezed
class FoodEvent with _$FoodEvent {
  const factory FoodEvent.getFoodList() = _GetFoodList;
  const factory FoodEvent.findFood({
    required String searchText
  }) = _FindFood;
  
  ///Добавляем уже созданную еду в список еды пользователя
  const factory FoodEvent.addingFood({
    required Food food
  }) = _AddingFood;

  const factory FoodEvent.createFood({
    required String title,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String calories,
  }) = _CreateFood;

  const factory FoodEvent.updateFood({
    required Food food,
    required String title,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String calories,
  }) = _UpdateFood;

  const factory FoodEvent.deleteFood({
    required Food food
  }) = _DeleteFood;

  ///Передаёт в эвенте еду, с которой дальше будет идти работа в другом виджете
  const factory FoodEvent.infoAboutFood({
    required Food food
  }) = _InfoAboutFood;
}