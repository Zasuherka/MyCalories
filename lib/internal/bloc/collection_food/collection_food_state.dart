part of 'collection_food_bloc.dart';

@freezed
class CollectionFoodState with _$CollectionFoodState {
  const factory CollectionFoodState.initial() = _Initial;
  const factory CollectionFoodState.loading() = _Loading;
  const factory CollectionFoodState.success() = _Success;
  const factory CollectionFoodState.collection({
    required Collection collection,
    required bool isUserCollection,
    required bool userHaveThisCollection,
  }) = _CollectionFood;
  const factory CollectionFoodState.failure({
    required String errorText
  }) = _Failure;
}

