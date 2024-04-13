import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/data/repository/collection_repository.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/repository/i_collection_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_event.dart';
part 'collection_state.dart';
part 'collection_bloc.freezed.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {

  final ICollectionRepository _collectionService = CollectionRepository();
  final IUserRepository _userRepository = UserRepository();
  AppUser? localUser;

  List<Collection> listCollection = [];
  List<CollectionView> listCollectionView = [];

  CollectionBloc() : super(const CollectionState.initial()) {
    on<CollectionEvent>(
        transformer: restartable(),
        (event, emit) async {
          await event.map(
              getUserListCollection: (value) =>
                  _getUserListCollection(emit),
              getGlobalListCollection: (value) =>
                  _getGlobalListCollection(value.searchText, emit),
              createCollection: (value) =>
                  _createCollection(
                      value.listFood,
                      value.title,
                      emit
                  )
          );
        });

    localUser = _userRepository.localUser;
    if(localUser != null){
      listCollection = localUser!.listCollection;
      listCollectionView = localUser!.listCollectionView;
    }
    UserRepository.controller.stream.listen((event) {
      if(event != null){
        listCollection = event.listCollection;
        listCollectionView = event.listCollectionView;
      }
    });
  }

  Future _getUserListCollection(Emitter<CollectionState> emitter) async {
    if(listCollection.isEmpty){
      emitter(const CollectionState.loading());
      await _collectionService.getUserListCollection();
      emitter(CollectionState.listCollection(listCollection: listCollectionView));
    }
    else{
      await _collectionService.getUserListCollection();
      emitter(const CollectionState.loading());
      emitter(CollectionState.listCollection(listCollection: listCollectionView));
    }
  }

  Future _getGlobalListCollection(String searchText, Emitter<CollectionState> emitter) async {
    emitter(const CollectionState.loading());
    final List<CollectionView> listCollectionView = await _collectionService
        .findGlobalCollection(searchText);
    emitter(CollectionState.globalListCollection(listCollection: listCollectionView));
  }

  Future _createCollection(List<Food> listFood, String title, Emitter<CollectionState> emitter) async {
    emitter(const CollectionState.loading());
    await _collectionService.createCollection(listFood: listFood, title: title);
    emitter(CollectionState.listCollection(listCollection: listCollectionView));
  }
}
