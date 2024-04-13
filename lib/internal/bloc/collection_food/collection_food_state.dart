part of 'collection_food_bloc.dart';

@freezed
class CollectionFoodState with _$CollectionFoodState {
  const factory CollectionFoodState.initial() = _Initial;
  const factory CollectionFoodState.loading() = _Loading;
  const factory CollectionFoodState.collectionFood({
    required List<Food> list
  }) = _CollectionFood;
  const factory CollectionFoodState.failure({
    required String errorText
  }) = _Failure;
}

