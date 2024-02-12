part of 'eating_food_bloc.dart';


@freezed
class EatingFoodEvent with _$EatingFoodEvent {
  /// Удаление еды из приёма пищи
  const factory EatingFoodEvent.deleteEatingFood() = _DeleteEatingFood;
  ///Обновление информации о [eatingBreakfast], [eatingLunch],
  ///[eatingDinner], [eatingAnother].
  const factory EatingFoodEvent.updateEatingState() = _UpdateEatingState;

  ///Добавление еды в приём пищи
  const factory EatingFoodEvent.addEatingFood({
    required String idFood,
    required String title,
    required double protein,
    required double fats,
    required double carbohydrates,
    required double calories,
    required int weight,
  }) = _AddEatingFood;

  ///Обновление сьеденной еды. По факту обновляется только весовка
  const factory EatingFoodEvent.updateEatingFood({
    required int index,
    required int weight,
  }) = _UpdateEatingFood;

  ///Получение названия приёма пищи, с которым далее планируем какие-либо действия
  const factory EatingFoodEvent.getNameEating({
    required String nameEating
  }) = _GetNameEating;

  ///Получение информации о еде, с которой планируем какие-либо действия
  const factory EatingFoodEvent.getEatingFoodInfo({
    required EatingFood eatingFood,
    required int index,
    required String nameEating,
  }) = _GetEatingFoodInfo;
}