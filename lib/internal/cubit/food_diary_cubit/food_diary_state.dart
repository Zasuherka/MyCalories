part of 'food_diary_cubit.dart';

@freezed
class FoodDiaryState with _$FoodDiaryState {
  const factory FoodDiaryState.initial() = _Initial;
  const factory FoodDiaryState.loading() = _Loading;
  const factory FoodDiaryState.success() = _Success;
}