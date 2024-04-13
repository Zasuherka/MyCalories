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
      listFood.add(await getFoodById(foodId));
    }
    return listFood;
  }

  Future<Food> getFoodById(String foodId) async {
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

  Future<List<Collection>> getUserListCollection(String email, List<String> listCollectionsId) async {

    List<Collection> listCollection = [];

    final Query query = _collectionsRef.orderByChild('authorEmail').startAt(
        email);
    final snapshot = await query.get();

    for (DataSnapshot collectionSnap in snapshot.children) {
      if (listCollectionsId.contains(collectionSnap.key)) {
        final list = collectionSnap
            .child('foodsId')
            .value as List<Object?>;
        final List<Food> listFood = [];
        for (String id in list.map((id) => id.toString())) {
          final foodRef = _foodsRef.child(id);
          final foodSnap = await foodRef.get();
          final Map<String, dynamic> map = Map<String, dynamic>
              .from(foodSnap.value as Map);
          map['idFood'] = id;
          listFood.add(Food.fromJson(map));
        }
        final collection = Collection(
          id: collectionSnap.key.toString(),
          title: collectionSnap
              .child('title')
              .value
              .toString(),
          authorEmail: collectionSnap
              .child('authorEmail')
              .value
              .toString(),
        );
        listCollection.add(collection);
      }
    }

    return listCollection;
  }
}