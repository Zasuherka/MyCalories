import 'package:app1/data/dto/collection/collection_dto.dart';
import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/data/database/database.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/repository/i_collection_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';

class CollectionRepository implements ICollectionRepository {

  final IUserRepository _userRepository = UserRepository();

  final Database _database = Database();

  @override
  Future<void> createCollection({
    required List<Food> listFood,
    required String title
  }) async {

    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is Null';
    }

    try{
      final listCollectionId = await _database.collectionData.createCollection(
          collectionDto: CollectionDto(
              authorEmail: localUser.email,
              lowerCaseTitle: title.toLowerCase(),
              title: title,
              foodsId: listFood.map((e) => e.idFood).toList()
          ),
          listCollectionId: localUser.listCollectionsId,
          userId: localUser.userId
      );

      localUser.listCollectionsId = listCollectionId;
      _userRepository.setUserInfo(localUser);
    }
    catch(_){}
  }

  @override
  Future getUserListCollection() async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }
    
    try{
      final list = await _database.collectionData.getUserListCollection(
          localUser.email,
          localUser.listCollectionsId
      );
      localUser.listCollection = list;
      _userRepository.setUserInfo(localUser);
    }
    catch(error){
      print(error);
    }
  }

  @override
  Future<List<CollectionView>> findGlobalCollection(String searchText) async {

    if (searchText == ' ' || searchText == '') {
      return <CollectionView>[];
    }

    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }

    List<CollectionView> listCollectionView = await _database
        .collectionData
        .findGlobalCollection(searchText);

    for(int i = 0; i < listCollectionView.length; i++){
      if(localUser.listCollectionsId.contains(listCollectionView[i].id.toString())){
        listCollectionView.removeAt(i);
        i--;
      }
    }

    return listCollectionView;
  }


  @override
  Future<Collection> getCollectionById(String collectionId) async {
    final localUser = _userRepository.localUser;
    
    if(localUser == null) {
      throw 'localUser равен нулю';
    }

    for(Collection collection in localUser.listCollection){
      if(collection.id == collectionId){
        return collection;
      }
    }

    return await _database
        .collectionData
        .getCollectionById(collectionId);
  }
}