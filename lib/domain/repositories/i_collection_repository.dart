import 'package:app1/domain/models/collection/collection.dart';
import 'package:app1/domain/models/collection/collection_view.dart';
import 'package:app1/domain/models/food.dart';

abstract class ICollectionRepository {

  Future<void> createCollection({
    required List<Food> listFood,
    required String title
  });

  Future<void> updateCollection({
    required List<Food> updateListFood,
    required Collection collection
  });

  Future<void> getUserListCollection();

  Future<List<CollectionView>> findGlobalCollection(String searchText);

  Future<void> deleteCollectionFromList(String collectionId);

  Future<void> addCollectionInUserListCollection(Collection collection);

  Future<(Collection, bool, bool)> getCollectionById(String collectionId);
}