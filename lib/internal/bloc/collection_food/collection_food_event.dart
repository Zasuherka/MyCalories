part of 'collection_food_bloc.dart';

@freezed
class CollectionFoodEvent with _$CollectionFoodEvent {
  const factory CollectionFoodEvent.getCollection({
    required String collectionId
  }) = _GetCollection;

  const factory CollectionFoodEvent.deleteCollection({
    required String collectionId
  }) = _DeleteCollection;

  const factory CollectionFoodEvent.updateCollection({
    required List<Food> updateListFood,
    required Collection collection
  }) = _UpdateCollection;

  const factory CollectionFoodEvent.addCollectionInUserListCollection({
    required Collection collection
  }) = _AddCollectionInUserListCollection;
}