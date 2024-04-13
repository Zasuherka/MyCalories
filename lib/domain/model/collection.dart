import 'package:app1/domain/model/food.dart';

class Collection {
  final String id;
  final String title;
  final String authorEmail;
  List<Food> listFood = [];

  Collection({
    required this.id,
    required this.title,
    required this.authorEmail,
  });

  List<String> get listFoodIds => listFood.map((food) => food.idFood).toList();
}
