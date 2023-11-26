part of 'food_bloc.dart';

abstract class FoodEvent {}

class FoodInitialEvent extends FoodEvent {}

class GetListFoodEvent extends FoodEvent{}

class FindFoodEvent extends FoodEvent{
  final String searchText;

  FindFoodEvent(this.searchText);
}

class AddingFoodEvent extends FoodEvent{
  final Food food;

  AddingFoodEvent(this.food);
}

class CreateFoodEvent extends FoodEvent{
  final String title;
  final String protein;
  final String fats;
  final String carbohydrates;
  final String calories;

  CreateFoodEvent(this.title, this.protein, this.fats, this.carbohydrates, this.calories);
}

class UpdateFoodEvent extends FoodEvent{
  final Food food;
  final String title;
  final String protein;
  final String fats;
  final String carbohydrates;
  final String calories;

  UpdateFoodEvent(this.food, this.title, this.protein, this.fats, this.carbohydrates, this.calories);
}

class DeleteFoodEvent extends FoodEvent{
  final Food food;

  DeleteFoodEvent(this.food);
}

class GetFoodInfoEvent extends FoodEvent {
  final Food food;

  GetFoodInfoEvent(this.food);
}