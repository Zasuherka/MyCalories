part of 'eating_food_bloc.dart';

@immutable
abstract class EatingFoodState {
  final EatingFood? eatingFood;

  const EatingFoodState([this.eatingFood]);
  get eatingValues => null; ///Для того, чтобы в паре состояний можно было вернуть final Map<String, double> eatingValues;
}

class UpdateListState extends EatingFoodState{}

class EatingFoodInitialState extends EatingFoodState {}

class GetEatingFoodState extends EatingFoodState{}

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

  const GetEatingFoodInfoState(super.eatingFood, this.index, this.nameEating);
}
