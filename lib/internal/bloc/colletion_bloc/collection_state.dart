part of 'collection_bloc.dart';

@freezed
class CollectionState with _$CollectionState{
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loading() = _Loading;
  const factory CollectionState.listCollection({required List<CollectionView> listCollection}) = _ListCollection;
  const factory CollectionState.globalListCollection({required List<CollectionView> listCollection}) = _GlobalListCollection;
}
