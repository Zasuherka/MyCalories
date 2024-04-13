part of 'food_bloc.dart';

@freezed
class FoodState with _$FoodState {
  const factory FoodState.initial() = _Initial;
  const factory FoodState.loading() = _Loading;
  const factory FoodState.listFood({
    required List<Food> list
  }) = _ListFood;
  const factory FoodState.findListFood({
    required List<Food> userListFood,
    required List<Food> globalListFood,
  }) = _FindListFood;
  const factory FoodState.error({
    required String error
  }) = _Error;
  const factory FoodState.getFoodInfo({
    required Food? food
  }) = _GetFoodInfo;
}
