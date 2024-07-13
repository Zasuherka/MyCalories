import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/repository/i_collection_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_food_event.dart';
part 'collection_food_state.dart';
part 'collection_food_bloc.freezed.dart';

class CollectionFoodBloc extends Bloc<CollectionFoodEvent, CollectionFoodState> {

  final ICollectionRepository _collectionRepository;

  CollectionFoodBloc({required ICollectionRepository collectionRepository})
      : _collectionRepository = collectionRepository,
        super(const CollectionFoodState.initial()) {
    on<CollectionFoodEvent>(transformer: restartable(), (event, emit) async {
      await event.map(
          getCollection: (value) => _getCollection(value.collectionId, emit),
          updateCollection: (value) =>
              _updateCollection(value.updateListFood, value.collection, value.title, emit),
          deleteCollection: (value) => _deleteCollectionFromList(value.collectionId, emit),
          addCollectionInUserListCollection: (value) =>
              _addCollectionInUserListCollection(value.collection, emit));
    });
  }

  Future<void> _getCollection(
      String collectionId,
      Emitter<CollectionFoodState> emitter) async
  {
    emitter(const CollectionFoodState.loading());
    final response = await _collectionRepository.getCollectionById(collectionId);
    emitter(CollectionFoodState.collection(
        collection: response.$1,
        isUserCollection: response.$2,
        userHaveThisCollection: response.$3
    ));
  }

  Future<void> _addCollectionInUserListCollection(Collection collection,
      Emitter<CollectionFoodState> emitter) async {
    emitter(const CollectionFoodState.loading());
    try{
      await _collectionRepository.addCollectionInUserListCollection(collection);
      emitter(const CollectionFoodState.success());
    }
    catch(error){
      emitter(CollectionFoodState.failure(errorText: error.toString()));
    }
  }

  Future<void> _deleteCollectionFromList(String collectionId,
      Emitter<CollectionFoodState> emitter) async {
    emitter(const CollectionFoodState.loading());
    try{
      await _collectionRepository.deleteCollectionFromList(collectionId);
      emitter(const CollectionFoodState.success());
    }
    catch(error){
      emitter(CollectionFoodState.failure(errorText: error.toString()));
    }
  }

  Future<void> _updateCollection(
      List<Food> updateListFood,
      Collection collection,
      String title,
      Emitter<CollectionFoodState> emitter
      ) async {
    await _collectionRepository
        .updateCollection(updateListFood: updateListFood, collection: collection, title: title);
  }
}
