part of 'food_bloc.dart';

@immutable
abstract class FoodState {}

class FoodInitialState extends FoodState {}

class GetFoodListState extends FoodState {
  final List<Food> list;
  GetFoodListState(this.list);
}

class FindFoodListState extends FoodState {
  final List<Food> userFoodList;
  final List<Food> globalFoodList;

  FindFoodListState(this.userFoodList, this.globalFoodList);
}

class ErrorFoodState extends FoodState{
  final String errorText;

  ErrorFoodState(this.errorText);
}
