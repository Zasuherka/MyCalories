import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/food.dart';

abstract class ICollectionRepository {

  Future<void> createCollection({
    required List<Food> listFood,
    required String title
  });

  Future getUserListCollection();

  Future<List<CollectionView>> findGlobalCollection(String searchText);

  Future<Collection> getCollectionById(String collectionId);

}