part of 'food_bloc.dart';

@immutable
abstract class FoodState {
  final Food? food;

  const FoodState([this.food]);
}

class FoodInitialState extends FoodState {}

class GetFoodListState extends FoodState {
  final List<Food> list;
  const GetFoodListState(this.list);
}

class FindFoodListState extends FoodState {
  final List<Food> userFoodList;
  final List<Food> globalFoodList;

  const FindFoodListState(this.userFoodList, this.globalFoodList);
}

class ErrorFoodState extends FoodState{
  final String errorText;

  const ErrorFoodState(this.errorText);
}

class GetFoodInfoState extends FoodState {
  const GetFoodInfoState(super.food);
}
