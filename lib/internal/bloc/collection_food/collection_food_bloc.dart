import 'package:app1/domain/model/food.dart';
import 'package:app1/data/repository/collection_repository.dart';
import 'package:app1/domain/repository/i_collection_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'collection_food_event.dart';
part 'collection_food_state.dart';
part 'collection_food_bloc.freezed.dart';

class CollectionFoodBloc extends Bloc<CollectionFoodEvent, CollectionFoodState> {

  final ICollectionRepository _collectionService = CollectionRepository();

  CollectionFoodBloc() : super(const CollectionFoodState.initial()) {
    on<CollectionFoodEvent>((event, emit) async {
      await event.map(
          getCollection: (value) => _getCollection(value.collectionId, emit),
          updateCollection: (value) => _updateCollection(value.listFoodsId, emit)
      );
    });
  }

  Future<void> _getCollection(
      String collectionId,
      Emitter<CollectionFoodState> emitter) async
  {
    await _collectionService.getCollectionById(collectionId);
  }

  Future<void> _updateCollection(
      List<String> listFoodsId,
      Emitter<CollectionFoodState> emitter) async {

  }
}
