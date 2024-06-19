import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/food.dart';

abstract class ICollectionRepository {

  Future<List<CollectionView>> createCollection({
    required List<Food> listFood,
    required String title
  });

  Future<void> updateCollection({
    required List<Food> updateListFood,
    required Collection collection,
    required String title,
  });

  Future<void> getUserListCollection();

  Future<List<CollectionView>> findGlobalCollection(String searchText);

  Future<void> deleteCollectionFromList(String collectionId);

  Future<void> addCollectionInUserListCollection(Collection collection);

  Future<(Collection, bool, bool)> getCollectionById(String collectionId);
}