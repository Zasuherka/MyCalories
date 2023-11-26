part of 'eating_food_bloc.dart';

@immutable
abstract class EatingFoodState {
  final EatingFood? eatingFood;

  const EatingFoodState([this.eatingFood]);
  get eatingValues => null; ///Для того, чтобы в паре состояний можно было вернуть final Map<String, double> eatingValues;
}

class UpdateListState extends EatingFoodState{}

class EatingFoodInitialState extends EatingFoodState {
  final Map<String, List<EatingFood>> initialList;
  final Map<String, String> initialCalories;
  @override
  final Map<String, double> eatingValues;

  const EatingFoodInitialState(this.initialList, this.eatingValues, this.initialCalories);
}

class GetEatingFoodListState extends EatingFoodState{
  final List<EatingFood> eatingFoodList;
  final String nameEating;
  final String eatingCalories;
  @override
  final Map<String, double> eatingValues;

  const GetEatingFoodListState(this.eatingFoodList, this.nameEating, this.eatingCalories, this.eatingValues);
}

class AddEatingFoodListState extends EatingFoodState {
  final String nameEating;

  const AddEatingFoodListState(super.eatingFood, this.nameEating);
}

class ErrorEatingFoodState extends EatingFoodState {
  final String error;

  const ErrorEatingFoodState(this.error);
}

class GetEatingFoodInfoState extends EatingFoodState {
  final int index;
  final String nameEating;

  const GetEatingFoodInfoState(super.eatingFood, this.index, this.nameEating);}
