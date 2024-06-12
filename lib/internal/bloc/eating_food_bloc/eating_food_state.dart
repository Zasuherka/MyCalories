part of 'eating_food_bloc.dart';

@freezed
class EatingFoodState with _$EatingFoodState {
  const EatingFoodState._();
  const factory EatingFoodState.initial() = _Initial;
  const factory EatingFoodState.loading() = _Loading;
  const factory EatingFoodState.success() = _Success;
  const factory EatingFoodState.error({
    required String error
  }) = _Error;
  const factory EatingFoodState.eatingFoodInfo({
    required int index,
    required String nameEating,
    required EatingFood? eatingFood
  }) = _EatingFoodInfo;

  get eatingValues => null; ///Для того, чтобы в паре состояний можно было вернуть final Map<String, double> eatingValues;
}
