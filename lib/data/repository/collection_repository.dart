import 'package:app1/data/dto/collection/collection_dto.dart';
import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/data/database/database.dart';
import 'package:app1/domain/repository/i_collection_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';

class CollectionRepository implements ICollectionRepository {

  final IUserRepository _userRepository;

  final Database _database;

  CollectionRepository({required IUserRepository userRepository, required Database database})
      : _userRepository = userRepository,
        _database = database;

  @override
  Future<List<CollectionView>> createCollection({required List<Food> listFood, required String title}) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser is Null';
    }

    try {
      final listCollectionId = await _database.collectionData.createCollection(
          collectionDto: CollectionDto(
              authorEmail: localUser.email,
              lowerCaseTitle: title.toLowerCase(),
              title: title,
              foodsId: listFood.map((e) => e.idFood).toList()),
          listCollectionId: localUser.listCollectionsId,
          userId: localUser.userId);
      final CollectionView collectionView = CollectionView(
        localUser.listCollectionsId.last,
        title,
        localUser.email,
      );
      localUser.listCollectionView.add(collectionView);
      localUser.listCollectionsId = listCollectionId;
      _userRepository.setUserInfo(localUser);
      return localUser.listCollectionView;
    } catch (_) {
      return localUser.listCollectionView;
    }
  }

  @override
  Future<void> updateCollection({
    required List<Food> updateListFood,
    required Collection collection,
    required String title,
  }) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser is Null';
    }

    collection.listFood = updateListFood;

    try {
      await _database.collectionData.updateCollection(
          collectionDto: CollectionDto(
              authorEmail: collection.authorEmail,
              lowerCaseTitle: collection.title.toLowerCase(),
              title: title,
              foodsId: collection.listFoodIds),
          collectionId: collection.id);
      _userRepository.setUserInfo(localUser);
    } catch (_) {}
  }

  @override
  Future<void> getUserListCollection() async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }
    try {
      final list =
          await _database.collectionData.getUserListCollection(localUser.listCollectionsId);
      localUser.listCollection = list;
      _userRepository.setUserInfo(localUser);
    } catch (error) {}
  }

  @override
  Future<List<CollectionView>> findGlobalCollection(String searchText) async {
    if (searchText == ' ' || searchText == '') {
      return <CollectionView>[];
    }

    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    List<CollectionView> listCollectionView =
        await _database.collectionData.findGlobalCollection(searchText);

    for (int i = 0; i < listCollectionView.length; i++) {
      if (localUser.listCollectionsId.contains(listCollectionView[i].id.toString())) {
        listCollectionView.removeAt(i);
        i--;
      }
    }

    return listCollectionView;
  }

  @override
  Future<(Collection, bool, bool)> getCollectionById(String collectionId) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    // for(Collection collection in localUser.listCollection){
    //   if(collection.id == collectionId){
    //     if(collection.authorEmail == localUser.email){
    //       return (collection, true, true);
    //     }
    //     return (collection, false, true);
    //   }
    // }

    try {
      final collection = await _database.collectionData.getCollectionById(collectionId);

      if (localUser.email == collection.authorEmail) {
        for (CollectionView collectionView in localUser.listCollectionView) {
          if (collectionView.id == collection.id) {
            return (collection, true, true);
          }
        }
        return (collection, true, false);
      }
      for (CollectionView collectionView in localUser.listCollectionView) {
        if (collectionView.id == collection.id) {
          return (collection, false, true);
        }
      }
      return (collection, false, false);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCollectionFromList(String collectionId) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    try {
      localUser.listCollectionsId.removeWhere((element) => element == collectionId);
      localUser.listCollectionView.removeWhere((element) => element.id == collectionId);

      _userRepository.setUserInfo(localUser);

      await _database.collectionData
          .editUserListCollection(localUser.listCollectionsId, localUser.userId);
    } catch (_) {
      throw Exception('Ошбика при удаление коллекции из списка коллекций пользователя');
    }
  }

  @override
  Future<void> addCollectionInUserListCollection(Collection collection) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    if (localUser.listCollectionsId.contains(collection.id)) {
      throw Exception('В списке пользователя уже имеется данная коллекция');
    }

    try {
      localUser.listCollectionView.add(CollectionView.fromCollection(collection));
      localUser.listCollectionsId.add(collection.id);

      await _database.collectionData
          .editUserListCollection(localUser.listCollectionsId, localUser.userId);

      _userRepository.setUserInfo(localUser);
    } catch (error) {
      rethrow;
    }
  }
}
