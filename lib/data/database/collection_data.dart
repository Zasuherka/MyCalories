part of 'database.dart';

class _CollectionData{

  Future<List<String>> createCollection({
    required CollectionDto collectionDto,
    required List<String> listCollectionId,
    required String userId
  }) async {

    final collectionRef = _collectionsRef.push();

    await collectionRef.set(collectionDto.toJson());

    listCollectionId.add(collectionRef.key!);

    final userRef = _usersRef.child(userId);

    await userRef.update({
      'collections': listCollectionId
    });

    return listCollectionId;
  }

  Future<void> updateCollection({
    required CollectionDto collectionDto,
    required String collectionId,
  }) async {
    await _collectionsRef.child(collectionId).update(collectionDto.toJson());
  }

  Future<Collection> getCollectionById(String collectionId) async {
    final DataSnapshot snapshot = await _collectionsRef.child(collectionId).get();
    final List<String> listId = (snapshot.child('foodsId').value as List).map((e) => e as String).toList();
    final Collection collection = Collection(
      id: snapshot.key.toString(),
      title: snapshot.child('title').value.toString(),
      authorEmail: snapshot.child('authorEmail').value.toString(),
    );
    collection.listFood = await getListFoodByCollectionId(listId);
    return collection;
  }

  Future<List<Food>> getListFoodByCollectionId(List<String> listId) async {
    List<Food> listFood = [];
    for(String foodId in listId){
      listFood.add(await _getFoodById(foodId));
    }
    return listFood;
  }

  Future<Food> _getFoodById(String foodId) async {
    final DataSnapshot snapshot = await _foodsRef.child(foodId).get();
    final Map<String, dynamic> map = Map<String, dynamic>
        .from(snapshot.value as Map);
    map['idFood'] = snapshot.key;
    return Food.fromJson(map);
  }

  Future<List<CollectionView>> findGlobalCollection(String searchText) async {
    List<CollectionView> listCollectionView = [];
    final Query query = _collectionsRef
        .orderByChild('lowerCaseTitle')
        .startAt(searchText.toLowerCase())
        .endAt('${searchText.toLowerCase()}\uf8ff');
    final snapshot = await query.get();
    for(DataSnapshot collectionSnap in snapshot.children){
      final Map<String, dynamic> map = Map<String, dynamic>
          .from(collectionSnap.value as Map);
      map['id'] = collectionSnap.key;
      listCollectionView.add(CollectionView.fromJson(map));
    }
    return listCollectionView;
  }
  
  Future<void> editUserListCollection(List<String> newUserListCollectionId, String userId) async {
    try{
      await _usersRef.child(userId).update({
        'collections': newUserListCollectionId
      });
    }
    catch(error){
      throw Exception('Ошибка при добавлении коллекции в список коллекий пользователя');
    }
  }

  Future<List<CollectionView>> getUserListCollection(List<String> listCollectionsId) async {
    List<CollectionView> listCollectionView = [];

    for(String collectionId in listCollectionsId){
      final DataSnapshot snap = await _collectionsRef.child(collectionId).get();
      final String title = snap.child('title').value.toString();
      final String authorEmail = snap.child('authorEmail').value.toString();
      listCollectionView.add(CollectionView(collectionId, title, authorEmail));
    }

    return listCollectionView;
  }
}