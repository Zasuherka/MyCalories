part of 'food_bloc.dart';

@immutable
abstract class FoodState {}

class FoodInitialState extends FoodState {}

class GetFoodListState extends FoodState {
  final List<Food> list;
  GetFoodListState(this.list);

}

// class CreateFoodState extends FoodState {
//   final Food food;
//
//   CreateFoodState(this.food);
// }
//
// class UpdateFoodState extends FoodState {
//   final Food oldFood;
//   final Food newFood;
//
//   UpdateFoodState(this.oldFood, this.newFood);
// }
//
// class DeleteFoodState extends FoodState {
//   final Food food;
//
//   DeleteFoodState(this.food);
// }

class ErrorFoodState extends FoodState{}
