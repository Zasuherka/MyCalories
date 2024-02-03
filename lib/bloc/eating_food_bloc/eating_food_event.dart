part of 'eating_food_bloc.dart';

abstract class EatingFoodEvent {}

class UpdateListEvent extends EatingFoodEvent{}

class GetEatingFoodListEvent extends EatingFoodEvent{
  final String nameEating;

  GetEatingFoodListEvent(this.nameEating);
}

class GetAllEatingFoodListEvent extends EatingFoodEvent {}

class GetIsFoodEvent extends EatingFoodEvent{
  final String nameEating;

  GetIsFoodEvent(this.nameEating);
}

class DeleteEatingFoodEvent extends EatingFoodEvent{}

class UpdateEatingFoodEvent extends EatingFoodEvent{
  final int index;
  final int weight;

  UpdateEatingFoodEvent(this.index, this.weight);
}

class AddEatingFoodEvent extends EatingFoodEvent{
  final String idFood;
  final String title;
  final double protein;
  final double fats;
  final double carbohydrates;
  final double calories;
  final int weight;

  AddEatingFoodEvent(this.idFood, this.title, this.protein, this.fats, this.carbohydrates, this.calories, this.weight);
}

class GetEatingFoodInfoEvent extends EatingFoodEvent {
  final EatingFood eatingFood;
  final int index;
  final String nameEating;

  GetEatingFoodInfoEvent(this.eatingFood, this.index, this.nameEating);
}