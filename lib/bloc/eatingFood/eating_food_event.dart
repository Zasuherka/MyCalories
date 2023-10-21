part of 'eating_food_bloc.dart';

abstract class EatingFoodEvent {}

class UpdateListEvent extends EatingFoodEvent{}

class GetEatingFoodListEvent extends EatingFoodEvent{
  final String nameEating;

  GetEatingFoodListEvent(this.nameEating);
}

class GetIsFoodEvent extends EatingFoodEvent{
  final String nameEating;

  GetIsFoodEvent(this.nameEating);
}

class AddEatingFoodListEvent extends EatingFoodEvent{
  final String idFood;
  final String title;
  final double protein;
  final double fats;
  final double carbohydrates;
  final double calories;
  final int weight;

  AddEatingFoodListEvent(this.idFood, this.title, this.protein, this.fats, this.carbohydrates, this.calories, this.weight);
}