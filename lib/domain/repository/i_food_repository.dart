import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/food.dart';

abstract class IFoodRepository {

  Future<List<Food>?> createFood(String title, String protein, String fats,
      String carbohydrates, String calories);

  Future<List<Food>?> updateFood(Food food, String title, String protein,
      String fats, String carbohydrates, String calories);

  Future<List<Food>> findFood(String searchText);

  Future<List<Food>> findGlobalFood(String searchText);

  Future<List<Food>> addingFood(Food food);

  Future<void> getUserFoods();

  Future<bool> deleteFood(Food food);

  Future<(List<EatingFood>, String)> addFoodEatingList(
      String nameEating,
      String idFood,
      String title,
      double protein,
      double fats,
      double carbohydrates,
      double calories,
      int weight);

  Future<(List<EatingFood>, String)> updateFoodInEatingList(
      String nameEating, int index, int weight);

  Future<(List<EatingFood>, String)> deleteFoodInEatingList(
      String nameEating, int index);

  (List<EatingFood>, String) getEatingList(String nameEating);

  Future<(List<EatingFood>, List<EatingFood>, List<EatingFood>, List<EatingFood>)>
  getEatingFoodInfoInFirebase([DateTime? dateTime, bool saveUserInfo, String? userId]);

  String getCaloriesString(List<EatingFood> listEatingFood);

  double getCalories(List<EatingFood> listEatingFood);

  double getProtein(List<EatingFood> listEatingFood);

  double getFats(List<EatingFood> listEatingFood);

  double getCarbohydrates(List<EatingFood> listEatingFood);
}