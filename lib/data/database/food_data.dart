part of 'database.dart';

class _FoodData{
  Future<Food> createFood(FoodDto dto, String userId) async {
    try {
      final foodRef = _foodsRef.push();

      await foodRef.set(dto.toJson());

      final Food newFood = Food(
          foodRef.key.toString(),
          dto.authorEmail,
          dto.title,
          double.parse(dto.protein),
          double.parse(dto.fats),
          double.parse(dto.carbohydrates),
          double.parse(dto.calories));

      newFood.isUserFood = true;

      DataSnapshot listFoods = await _usersRef.child('$userId/myFoods').get();
      if (listFoods.value == null) {
        await _usersRef.child(userId).update({
          "myFoods": [foodRef.key]
        });
      } else {
        List newListFood = [];
        for (var food in listFoods.children) {
          newListFood.add(food.value.toString());
        }
        newListFood.add(foodRef.key);
        await _usersRef.child(userId).update({
          "myFoods": newListFood
        });
      }

      return newFood;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFood(FoodDto dto, String userId, String foodId) async {
    await _foodsRef.child(foodId).update(dto.toJson());
  }

  Future<List<Food>> findGlobalFood(String searchText) async {
    List<Food> findGlobalFoodList = [];
    final Query query = _foodsRef
        .orderByChild('lowerCaseTitle')
        .startAt(searchText.toLowerCase())
        .endAt('${searchText.toLowerCase()}\uf8ff');
    try {
      final DataSnapshot snapshot = await query.get();
      for (DataSnapshot snapshotFood in snapshot.children) {
        final Food findFood = Food(
            snapshotFood.key.toString(),
            snapshotFood.child('authorEmail').value.toString(),
            snapshotFood.child('title').value.toString(),
            double.parse(snapshotFood.child('protein').value.toString()),
            double.parse(snapshotFood.child('fats').value.toString()),
            double.parse(snapshotFood.child('carbohydrates').value.toString()),
            double.parse(snapshotFood.child('calories').value.toString()));
        findGlobalFoodList.add(findFood);
      }
    } catch (error) {
      print('error: ' + error.toString());
    }
    return findGlobalFoodList;
  }


  Future<void> addingFood(String foodId, String userId) async {
    try {
      DataSnapshot listFoods = await _usersRef.child('$userId/myFoods').get();
      if (listFoods.value == null) {
        await _usersRef.child(userId).update({
          "myFoods": [foodId]
        });
      } else {
        List newListFood = [];
        for (var food in listFoods.children) {
          newListFood.add(food.value.toString());
        }
        newListFood.add(foodId);
        await _usersRef.child(userId).update({"myFoods": newListFood});
      }
    } catch (error) {
      print('error: ' + error.toString());
    }
  }

  Future<List<Food>> getUserFoods(String userId, String email) async {
    List<Food> listFood = [];
    try {
      DataSnapshot listFoods = await _usersRef.child('$userId/myFoods').get();
      for (DataSnapshot food in listFoods.children) {
        DataSnapshot getFood = await _foodsRef.child('${food.value}').get();
        final Food newFood = Food(
            food.value.toString(),
            getFood.child('authorEmail').value.toString(),
            getFood.child('title').value.toString(),
            double.parse(getFood.child('protein').value.toString()),
            double.parse(getFood.child('fats').value.toString()),
            double.parse(getFood.child('carbohydrates').value.toString()),
            double.parse(getFood.child('calories').value.toString()));
        if (email == newFood.authorEmail) {
          newFood.isUserFood = true;
        } else {
          newFood.isUserFood = false;
        }
        newFood.isThisFoodOnTheMyFoodList = true;
        if (!listFood.contains(newFood)) {
          listFood.add(newFood);
        }
      }
    } catch (e) {
      Exception('ТУТ УБРАЛ HIVE, СДЕЛАТЬ ОБРАБОТЧИК СОБЫТИЙ');
    }
    return listFood;
  }

  Future<void> deleteFood(String foodId, String userId) async {
    try {
      DataSnapshot listFoods = await _usersRef.child('$userId/myFoods').get();
      List newListFood = [];
      for (DataSnapshot food in listFoods.children) {
        newListFood.add(food.value.toString());
      }
      newListFood.remove(foodId);
      await _usersRef.child(userId).update({
        "myFoods": newListFood
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setEatingInfoInFirebase(
      String date,
      String userId,
      List<Map<String, dynamic>> eatingBreakfast,
      List<Map<String, dynamic>> eatingLunch,
      List<Map<String, dynamic>> eatingDinner,
      List<Map<String, dynamic>> eatingAnother,
      ) async {

    try{
      await _usersRef.child('$userId/eatingByDate/$date').set({
        'eatingBreakfast': eatingBreakfast,
        'eatingLunch': eatingLunch,
        'eatingDinner': eatingDinner,
        'eatingAnother': eatingAnother
      });
    }
    catch(_){}
  }

  Future<(List<EatingFood>, List<EatingFood>, List<EatingFood>, List<EatingFood>)>
  getEatingFoodInfoInFirebase(String userId, String date) async {
    List<EatingFood> breakfast = [];
    List<EatingFood> lunch = [];
    List<EatingFood> dinner = [];
    List<EatingFood> another = [];

    try{
      final eatingInfo = await _usersRef.child('$userId/eatingByDate/$date').get();

      for (int i = 0; i < eatingInfo.child('eatingBreakfast').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.child('eatingBreakfast').child('$i').value as Map);
        breakfast.add(EatingFood.fromJson(eatingMap));
      }

      for (int i = 0; i < eatingInfo.child('eatingLunch').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.child('eatingLunch').child('$i').value as Map);
        lunch.add(EatingFood.fromJson(eatingMap));
      }

      for (int i = 0; i < eatingInfo.child('eatingDinner').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.child('eatingDinner').child('$i').value as Map);
        dinner.add(EatingFood.fromJson(eatingMap));
      }

      for (int i = 0; i < eatingInfo.child('eatingAnother').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.child('eatingAnother').child('$i').value as Map);
        another.add(EatingFood.fromJson(eatingMap));
      }
    }
    catch(_){}

    return (breakfast, lunch, dinner, another);
  }
}