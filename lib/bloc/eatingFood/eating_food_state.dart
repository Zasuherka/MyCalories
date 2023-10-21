part of 'eating_food_bloc.dart';

@immutable
abstract class EatingFoodState {
  get eatingValues => null; ///Для того, чтобы в паре состояний можно было вернуть final Map<String, double> eatingValues;
}

class UpdateListState extends EatingFoodState{}

class EatingFoodInitialState extends EatingFoodState {
  final Map<String, List<EatingFood>> initialList;
  final Map<String, String> initialCalories;
  @override
  final Map<String, double> eatingValues;

  EatingFoodInitialState(this.initialList, this.eatingValues, this.initialCalories);
}

class GetEatingFoodListState extends EatingFoodState{
  final List<EatingFood> eatingFoodList;
  final String nameEating;
  final String eatingCalories;
  @override
  final Map<String, double> eatingValues;

  GetEatingFoodListState(this.eatingFoodList, this.nameEating, this.eatingCalories, this.eatingValues);
}

class GetIsFoodState extends EatingFoodState {}

class GetEatingAddFoodPageState extends EatingFoodState{}

class AddEatingFoodListState extends EatingFoodState {
  final EatingFood eatingFood;
  final String nameEating;

  AddEatingFoodListState(this.eatingFood, this.nameEating);
}