part of 'collection_bloc.dart';

@freezed
class CollectionEvent with _$CollectionEvent {
  const factory CollectionEvent.getUserListCollection() = _GetUserListCollection;
  const factory CollectionEvent.getGlobalListCollection({required String searchText}) = _GetGlobalListCollection;
  const factory CollectionEvent.createCollection({
    required String title,
    required List<Food> listFood
  }) = _CreateCollection;
}
