import 'dart:async';
import 'package:app1/models/food.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:app1/models/eating_food.dart';
import 'package:intl/intl.dart';

class FoodService {
  final UserService _userService = UserService();
  static String _dateNow = DateFormat('ddMMyyyy').format(DateTime.now());

  ///Создание Еды, запись в БД, запись в список еды пользователя
  Future<List<Food>?> createFood(String title, String protein, String fats,
      String carbohydrates, String calories) async {
    final localUser = _userService.localUser;

    if (await _userService.isConnected() && localUser != null) {
      final listFood = localUser.myFoods;
      DatabaseReference ref = FirebaseDatabase.instance.ref("/foods");
      try {
        final foodRef = ref.push();
        await foodRef.set({
          "authorEmail": localUser.email,
          "title": title,
          "lowerCaseTitle": title.toLowerCase(),
          "protein": double.parse(protein).toStringAsFixed(2),
          "fats": double.parse(fats).toStringAsFixed(2),
          "carbohydrates": double.parse(carbohydrates).toStringAsFixed(2),
          "calories": double.parse(calories).toStringAsFixed(2)
        });
        final Food newFood = Food(
            foodRef.key.toString(),
            localUser.email,
            title,
            double.parse(protein),
            double.parse(fats),
            double.parse(carbohydrates),
            double.parse(calories));
        newFood.isUserFood = true;
        listFood.add(newFood);
        ref = FirebaseDatabase.instance.ref("/users/${localUser.userId}");
        DataSnapshot listFoods = await ref.child('myFoods').get();
        if (listFoods.value == null) {
          await ref.update({
            "myFoods": [foodRef.key]
          });
        } else {
          List newListFood = [];
          for (var food in listFoods.children) {
            newListFood.add(food.value.toString());
          }
          newListFood.add(foodRef.key);
          await ref.update({"myFoods": newListFood});
        }
        _userService.setFoodList(listFood);
        await setFoodInfo();
        return listFood;
      } catch (e) {
        print("Ошибка" + e.toString());
      }
    }
    return null;
  }

  ///Обновление информации о еде в БД и в списке
  Future<List<Food>?> updateFood(Food food, String title, String protein,
      String fats, String carbohydrates, String calories) async {
    final localUser = _userService.localUser;

    final String idFood = food.idFood;

    if (await _userService.isConnected() && localUser != null) {
      final listFood = localUser.myFoods;

      final foodRef = FirebaseDatabase.instance.ref("/foods/$idFood");
      try {
        await foodRef.update({
          "title": title,
          "lowerCaseTitle": title.toLowerCase(),
          "protein": double.parse(protein).toStringAsFixed(2),
          "fats": double.parse(fats).toStringAsFixed(2),
          "carbohydrates": double.parse(carbohydrates).toStringAsFixed(2),
          "calories": double.parse(calories).toStringAsFixed(2)
        });
        final int index = localUser.myFoods.indexOf(food);
        final Food updateFood = Food(
            idFood,
            localUser.email,
            title,
            double.parse(protein),
            double.parse(fats),
            double.parse(carbohydrates),
            double.parse(calories));
        updateFood.isUserFood = true;
        listFood[index] = updateFood;
        await setFoodInfo();
        return listFood;
      } catch (e) {
        throw "Ошибка обновления $e";
      }
    }
    return null;
  }

  ///Поиск еды в списке юзера
  Future<List<Food>> findFood(String searchText) async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'User is null';
    }
    if (searchText == '') {
      return localUser.myFoods;
    }
    if (localUser.myFoods.isEmpty) {
      return [];
    }
    if (searchText == ' ') {
      return [];
    }
    List<Food> findFoodList = [];
    for (Food food in localUser.myFoods) {
      if (food.title.toLowerCase().contains(searchText.toLowerCase())) {
        findFoodList.add(food);
      }
    }
    return findFoodList;
  }

  ///Глобальный поиск еды
  Future<List<Food>> findGlobalFood(String searchText) async {
    final localUser = _userService.localUser;
    if (localUser == null) {
      throw 'User is null';
    }
    if (searchText == ' ' || searchText == '') {
      return [];
    }

    final List<Food> listFood = localUser.myFoods;

    List<Food> findGlobalFoodList = [];
    final DatabaseReference foodsRef = FirebaseDatabase.instance.ref('foods');
    final Query query = foodsRef
        .orderByChild('lowerCaseTitle')
        .startAt(searchText.toLowerCase())
        .endAt('${searchText.toLowerCase()}\uf8ff');
    try {
      DatabaseEvent snapshot = await query.once();
      for (DataSnapshot snapshotFood in snapshot.snapshot.children) {
        final Food findFood = Food(
            snapshotFood.key.toString(),
            snapshotFood.child('authorEmail').value.toString(),
            snapshotFood.child('title').value.toString(),
            double.parse(snapshotFood.child('protein').value.toString()),
            double.parse(snapshotFood.child('fats').value.toString()),
            double.parse(snapshotFood.child('carbohydrates').value.toString()),
            double.parse(snapshotFood.child('calories').value.toString()));
        if (localUser.email == findFood.authorEmail) {
          findFood.isUserFood = true;
        } else {
          findFood.isUserFood = false;
        }
        findFood.isThisFoodOnTheMyFoodList = false;
        findGlobalFoodList.add(findFood);
        for (Food food in listFood) {
          if (findFood.idFood == food.idFood) {
            findGlobalFoodList.remove(findFood);
          }
        }
      }
    } catch (error) {
      print('error: ' + error.toString());
    }
    return findGlobalFoodList;
  }

  ///
  Future<List<Food>> addingFood(Food food) async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    final List<Food> listFood = localUser.myFoods;

    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("/users/${localUser.userId}");
      DataSnapshot listFoods = await ref.child('myFoods').get();
      if (listFoods.value == null) {
        await ref.update({
          "myFoods": [food.idFood]
        });
      } else {
        List newListFood = [];
        for (var food in listFoods.children) {
          newListFood.add(food.value.toString());
        }
        newListFood.add(food.idFood);
        await ref.update({"myFoods": newListFood});
      }
      food.isThisFoodOnTheMyFoodList = true;
      listFood.add(food);
    } catch (error) {
      print('error: ' + error.toString());
    }

    _userService.setFoodList(listFood);
    await setFoodInfo();
    return listFood;
  }

  ///Получение информации о списке еды пользователя, которая содержится в FireBase
  Future<void> getUserFoods() async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }
    List<Food> listFood = [];
    if (await _userService.isConnected()) {
      try {
        DatabaseReference ref =
            FirebaseDatabase.instance.ref('users/${localUser.userId}/myFoods');
        DataSnapshot listFoods = await ref.get();
        for (DataSnapshot food in listFoods.children) {
          ref = FirebaseDatabase.instance.ref('foods/${food.value}');
          DataSnapshot getFood = await ref.get();
          final Food newFood = Food(
              food.value.toString(),
              getFood.child('authorEmail').value.toString(),
              getFood.child('title').value.toString(),
              double.parse(getFood.child('protein').value.toString()),
              double.parse(getFood.child('fats').value.toString()),
              double.parse(getFood.child('carbohydrates').value.toString()),
              double.parse(getFood.child('calories').value.toString()));
          if (localUser.email == newFood.authorEmail) {
            newFood.isUserFood = true;
          } else {
            newFood.isUserFood = false;
          }
          newFood.isThisFoodOnTheMyFoodList = true;
          if (!listFood.contains(newFood)) {
            listFood.add(newFood);
          }
        }
        _userService.setFoodList(listFood);
        await setFoodInfo();
      } catch (e) {
        print('reading error: $e');
        await getFoodInfo();
      }
    } else {
      await getFoodInfo();
    }
  }

  ///Получаем список еды пользователя из Hive. Применяется это в случае отсутствия интернета
  Future getFoodInfo() async {
    final localUser = _userService.localUser;

    if (localUser != null) {
      final Box<List> foodBox = await Hive.openBox<List>('foodBox');
      if (foodBox.isEmpty) {
        _userService.setFoodList([]);
        return;
      }
      final List<Food> listFood = foodBox.get('foodList')?.cast<Food>() ?? [];
      _userService.setFoodList(listFood);
      await foodBox.close();
    }
  }

  ///Записываем обновлённый список еды пользователя в Hive
  Future setFoodInfo() async {
    final localUser = _userService.localUser;

    if (localUser != null) {
      final Box<List<Food>> foodBox = await Hive.openBox<List<Food>>('foodBox');
      await foodBox.put('foodList', localUser.myFoods);
      await foodBox.close();
    }
  }

  ///Получение списка еды пользователя в определённую дату
  Future<
      (
        List<EatingFood>,
        List<EatingFood>,
        List<EatingFood>,
        List<EatingFood>
      )> _getEatingFoodListsByDate(DateTime dateTime) async {
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final Box<List> eatingBox = await Hive.openBox<List>('eatingBox');
    List<EatingFood> breakfast = [];
    List<EatingFood> lunch = [];
    List<EatingFood> dinner = [];
    List<EatingFood> another = [];
    if (eatingBox.isEmpty) {
      return (breakfast, lunch, dinner, another);
    }
    breakfast =
        eatingBox.get('breakfast${dateTime.toString()}')?.cast<EatingFood>() ??
            [];
    lunch =
        eatingBox.get('lunch${dateTime.toString()}')?.cast<EatingFood>() ?? [];
    dinner =
        eatingBox.get('dinner${dateTime.toString()}')?.cast<EatingFood>() ?? [];
    another =
        eatingBox.get('another${dateTime.toString()}')?.cast<EatingFood>() ??
            [];
    await eatingBox.close();
    return (breakfast, lunch, dinner, another);
  }

  ///Получение приёмой пищи в текущую дату
  Future getEatingFoodInfoNow() async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'local равен нулю';
    }

    if (await _userService.isConnected()) {
      try {
        _userService.setEatingFoodListForLocalUser(
            await _getEatingFoodListsByDate(DateTime.now()));
        return;
      } on Exception catch (_) {
        print('Ошибка получения списков приёмов пищи с БД');
      }
    }

    final DateTime now = DateTime.now();
    final DateTime dateNow = DateTime(now.year, now.month, now.day);
    _userService.setEatingFoodListForLocalUser(await _getEatingFoodListsByDate(dateNow));
  }

  ///Пока что будет способ сохранения только на текущую дату
  Future _setEatingFoodInfoNow() async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'local равен нулю';
    }

    ///Логика тут ломает ум, поэтому комментарии исключительно для меня

    ///Получаем данные о текущей дате
    final DateTime now = DateTime.now();
    final DateTime dateNow = DateTime(now.year, now.month, now.day);

    ///Открываем [eatingBox]
    final Box<List> eatingBox = await Hive.openBox<List>('eatingBox');

    ///Сохраняем списки со съеденной едой по ключу в формате ["название приёма пищи + дата"]
    await eatingBox.put(
        'breakfast${dateNow.toString()}', localUser.eatingBreakfast);
    await eatingBox.put('lunch${dateNow.toString()}', localUser.eatingLunch);
    await eatingBox.put('dinner${dateNow.toString()}', localUser.eatingDinner);
    await eatingBox.put(
        'another${dateNow.toString()}', localUser.eatingAnother);
    await eatingBox.close();
  }

  ///Удаление еды из списка юзера, НО не из БД
  Future<bool> deleteFood(Food food) async {
    final localUser = _userService.localUser;

    if (localUser != null && await _userService.isConnected()) {
      final List<Food> listFood = localUser.myFoods;

      final String idFood = food.idFood;
      listFood.remove(food);
      _userService.setFoodList(listFood);
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("/users/${localUser.userId}");
      DataSnapshot listFoods = await ref.child('myFoods').get();
      List newListFood = [];
      for (var food in listFoods.children) {
        newListFood.add(food.value.toString());
      }
      newListFood.remove(idFood);
      try {
        await ref.update({"myFoods": newListFood});
      } catch (error) {
        throw 'delete food error: $error';
      }
      await setFoodInfo();
      return true;
    }
    return false;
  }

  ///Добавление еды в приём пищи
  Future<(List<EatingFood>, String)> addFoodEatingList(
      String nameEating,
      String idFood,
      String title,
      double protein,
      double fats,
      double carbohydrates,
      double calories,
      int weight) async {

    ///Получаем дату на момент получение запроса на добавление еды в приём пищи
    final String dateNow = DateFormat('ddMMyyyy').format(DateTime.now());

    /// Сравниваем [dateNow] и [_dateNow]. Если они не равны, значит наступил новый день
    if(_dateNow != dateNow){
      _dateNow = dateNow;
      await getEatingFoodInfoInFirebase();
    }

    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    final EatingFood eatingFood = EatingFood(idFood, localUser.email, title,
        protein, fats, carbohydrates, calories, weight);

    List<EatingFood> listEatingFood = [];
    if (nameEating == 'Завтрак') {
      localUser.eatingBreakfast.add(eatingFood);
      listEatingFood = localUser.eatingBreakfast;
    } else
    if (nameEating == 'Обед') {
      localUser.eatingLunch.add(eatingFood);
      listEatingFood = localUser.eatingLunch;
    } else
    if (nameEating == 'Ужин') {
      localUser.eatingDinner.add(eatingFood);
      listEatingFood = localUser.eatingDinner;
    } else{
      localUser.eatingAnother.add(eatingFood);
      listEatingFood = localUser.eatingAnother;
    }
    await _userService.setEatingFoodListForLocalUser((
      localUser.eatingBreakfast,
      localUser.eatingLunch,
      localUser.eatingDinner,
      localUser.eatingAnother
    ));
    await _setEatingInfoInFirebase();
    await _setEatingFoodInfoNow();
    return (listEatingFood, getCalories(listEatingFood));
  }

  ///Редактирование еды, которая добавлена в список приёма пищи
  Future<(List<EatingFood>, String)> updateFoodInEatingList(
      String nameEating, int index, int weight) async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    List<EatingFood> listEatingFood = [];

    if (nameEating == 'Завтрак') {
      print(localUser.eatingBreakfast[index].protein);
      localUser.eatingBreakfast[index].weight = weight;
    } else
    if (nameEating == 'Обед') {
      localUser.eatingLunch[index].weight = weight;
    } else
    if (nameEating == 'Ужин') {
      localUser.eatingDinner[index].weight = weight;
    } else{
      localUser.eatingAnother[index].weight = weight;
    }
    await _userService.setEatingFoodListForLocalUser((
      localUser.eatingBreakfast,
      localUser.eatingLunch,
      localUser.eatingDinner,
      localUser.eatingAnother
    ));
    await _setEatingInfoInFirebase();
    await _setEatingFoodInfoNow();
    return (listEatingFood, getCalories(listEatingFood));
  }

  ///Удаление еды из приёма пищи
  Future<(List<EatingFood>, String)> deleteFoodInEatingList(
      String nameEating, int index) async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    List<EatingFood> listEatingFood = [];

    if (nameEating == 'Завтрак') {
      localUser.eatingBreakfast.removeAt(index);
      listEatingFood = localUser.eatingBreakfast;
    } else
    if (nameEating == 'Обед') {
      localUser.eatingLunch.removeAt(index);
      listEatingFood = localUser.eatingLunch;
    } else
    if (nameEating == 'Ужин') {
      localUser.eatingDinner.removeAt(index);
      listEatingFood = localUser.eatingDinner;
    } else{
      localUser.eatingAnother.removeAt(index);
      listEatingFood = localUser.eatingAnother;
    }

    await _userService.setEatingFoodListForLocalUser((
      localUser.eatingBreakfast,
        localUser.eatingLunch,
        localUser.eatingDinner,
        localUser.eatingAnother
    ));
    await _setEatingInfoInFirebase();
    await _setEatingFoodInfoNow();
    return (listEatingFood, getCalories(listEatingFood));
  }

  ///Получение приёма пищи по названию
  (List<EatingFood>, String) getEatingList(String nameEating) {
    final localUser = _userService.localUser;
    if (localUser == null) {
      throw 'localUser равен нулю';
    }
    if (nameEating == 'Завтрак') {
      return (localUser.eatingBreakfast, getCalories(localUser.eatingBreakfast)
      );
    }
    if (nameEating == 'Обед') {
      return (localUser.eatingLunch, getCalories(localUser.eatingLunch));
    }
    if (nameEating == 'Ужин') {
      return (localUser.eatingDinner, getCalories(localUser.eatingDinner));
    }
    return (localUser.eatingAnother, getCalories(localUser.eatingAnother));
  }

  String getCalories(List<EatingFood> listEatingFood) {
    double calories = 0;
    for (EatingFood food in listEatingFood) {
      calories += food.calories / 100 * food.weight;
    }
    return calories.toStringAsFixed(2);
  }

  Future _setEatingInfoInFirebase() async {
    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    final DateTime dateNow =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    List eatingBreakfast = [];
    for (EatingFood eatingFood in localUser.eatingBreakfast) {
      eatingBreakfast.add(eatingFood.toJson());
    }
    List eatingLunch = [];
    for (EatingFood eatingFood in localUser.eatingLunch) {
      eatingLunch.add(eatingFood.toJson());
    }
    List eatingDinner = [];
    for (EatingFood eatingFood in localUser.eatingDinner) {
      eatingDinner.add(eatingFood.toJson());
    }
    List eatingAnother = [];
    for (EatingFood eatingFood in localUser.eatingAnother) {
      eatingAnother.add(eatingFood.toJson());
    }

    final DatabaseReference userRef = FirebaseDatabase.instance.ref(
        'users/${localUser.userId}/eatingByDate/${DateFormat('ddMMyyyy').format(dateNow)}');
    try {
      await userRef.set({
        'eatingBreakfast': eatingBreakfast,
        'eatingLunch': eatingLunch,
        'eatingDinner': eatingDinner,
        'eatingAnother': eatingAnother
      });
    } catch (error) {
      throw error.toString();
    }
  }

  Future<(List<EatingFood>, List<EatingFood>, List<EatingFood>, List<EatingFood>)>
  getEatingFoodInfoInFirebase([DateTime? dateTime]) async {

    final localUser = _userService.localUser;

    if (localUser == null) {
      throw 'localUser is null';
    }

    List<EatingFood> breakfast = [];
    List<EatingFood> lunch = [];
    List<EatingFood> dinner = [];
    List<EatingFood> another = [];
    try {
      final String dateFormat = dateTime != null
          ? DateFormat('ddMMyyyy').format(dateTime)
          : _dateNow;

      final DatabaseReference userRef = FirebaseDatabase.instance
          .ref('users/${localUser.userId}/eatingByDate/$dateFormat');

      final DatabaseEvent eatingInfo = await userRef.once();

      for (int i = 0; i < eatingInfo.snapshot.child('eatingBreakfast').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.snapshot.child('eatingBreakfast').child('$i').value as Map);
        breakfast.add(EatingFood.fromJson(eatingMap));
      }

      for (int i = 0; i < eatingInfo.snapshot.child('eatingLunch').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.snapshot.child('eatingLunch').child('$i').value as Map);
        lunch.add(EatingFood.fromJson(eatingMap));
      }

      for (int i = 0; i < eatingInfo.snapshot.child('eatingDinner').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.snapshot.child('eatingDinner').child('$i').value as Map);
        dinner.add(EatingFood.fromJson(eatingMap));
      }

      for (int i = 0; i < eatingInfo.snapshot.child('eatingAnother').children.length; i++) {
        Map<String, dynamic> eatingMap = Map<String, dynamic>.from(
            eatingInfo.snapshot.child('eatingAnother').child('$i').value as Map);
        another.add(EatingFood.fromJson(eatingMap));
      }

      await _userService.setEatingFoodListForLocalUser((breakfast, lunch, dinner, another));
      await _setEatingFoodInfoNow();
    } on Exception catch (error) {
      throw error.toString();
    }
    return (breakfast, lunch, dinner, another);
  }
}
