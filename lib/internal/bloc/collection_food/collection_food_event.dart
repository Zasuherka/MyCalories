part of 'collection_food_bloc.dart';

@freezed
class CollectionFoodEvent with _$CollectionFoodEvent {
  const factory CollectionFoodEvent.getCollection({
    required String collectionId
  }) = _GetCollection;

  const factory CollectionFoodEvent.updateCollection({
    required List<String> listFoodsId
  }) = UpdateCollection;
}