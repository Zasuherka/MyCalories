import 'dart:async';
import 'package:app1/data/database/database.dart';
import 'package:app1/data/dto/create_food/food_dto.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/repository/i_food_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:intl/intl.dart';

class FoodRepository implements IFoodRepository {
  final IUserRepository _userRepository = UserRepository();
  static String _dateNow = DateFormat('ddMMyyyy').format(DateTime.now());

  final Database _database = Database();

  ///Создание Еды, запись в БД, запись в список еды пользователя
  @override
  Future<List<Food>?> createFood(String title, String protein, String fats,
      String carbohydrates, String calories) async {
    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is null';
    }

    try {
      final listFood = localUser.myFoods;

      final newFood = await _database.foodData.createFood(
          FoodDto(
              title: title,
              lowerCaseTitle: title.toLowerCase(),
              protein: double.parse(protein).toStringAsFixed(2),
              fats: double.parse(fats).toStringAsFixed(2),
              carbohydrates: double.parse(carbohydrates).toStringAsFixed(2),
              calories: double.parse(calories).toStringAsFixed(2),
              authorEmail: localUser.email
          ),
          localUser.userId
      );

      listFood.add(newFood);
      _userRepository.setFoodList(listFood);
      return listFood;
    } catch (e) {
      print("Ошибка" + e.toString());
    }
    return null;
  }

  ///Обновление информации о еде в БД и в списке
  @override
  Future<List<Food>?> updateFood(Food food, String title, String protein,
      String fats, String carbohydrates, String calories) async {
    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser is null';
    }

    final listFood = localUser.myFoods;

    try{
      await _database.foodData.updateFood(
          FoodDto(
              title: title,
              lowerCaseTitle: title.toLowerCase(),
              protein: double.parse(protein).toStringAsFixed(2),
              fats: double.parse(fats).toStringAsFixed(2),
              carbohydrates: double.parse(carbohydrates).toStringAsFixed(2),
              calories: double.parse(calories).toStringAsFixed(2),
              authorEmail: localUser.email
          ),
          localUser.userId,
          food.idFood
      );
      final Food updateFood = Food(
          food.idFood,
          localUser.email,
          title,
          double.parse(protein),
          double.parse(fats),
          double.parse(carbohydrates),
          double.parse(calories)
      );
      updateFood.isUserFood = true;
      final int index = localUser.myFoods.indexOf(food);
      listFood[index] = updateFood;
      _userRepository.setFoodList(listFood);
      return listFood;
    }
    catch(e){
      print('Ошибка обновления $e');
    }
    return null;
  }

  ///Поиск еды в списке юзера
  @override
  Future<List<Food>> findFood(String searchText) async {
    final localUser = _userRepository.localUser;

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
  @override
  Future<List<Food>> findGlobalFood(String searchText) async {
    final localUser = _userRepository.localUser;
    if (localUser == null) {
      throw 'User is null';
    }
    if (searchText == ' ' || searchText == '') {
      return [];
    }

    final listFood = await _database.foodData.findGlobalFood(searchText);

    for(int i = 0; i < listFood.length; i++){
      if(localUser.myFoods.contains(listFood[i])){
        listFood.removeAt(i);
        i--;
        continue;
      }
      listFood[i].isThisFoodOnTheMyFoodList = false;
      if (localUser.email == listFood[i].authorEmail) {
        listFood[i].isUserFood = true;
      } else {
        listFood[i].isUserFood = false;
      }
    }

    return listFood;
  }

  ///
  @override
  Future<List<Food>> addingFood(Food food) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    await _database.foodData.addingFood(food.idFood, localUser.userId);

    final List<Food> listFood = localUser.myFoods;

    food.isThisFoodOnTheMyFoodList = true;

    listFood.add(food);
    _userRepository.setFoodList(listFood);
    return listFood;
  }

  ///Получение информации о списке еды пользователя, которая содержится в FireBase
  @override
  Future<void> getUserFoods() async {

    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    final List<Food> listFood = await _database.foodData
        .getUserFoods(localUser.userId, localUser.email);

    _userRepository.setFoodList(listFood);
  }

  ///Получаем список еды пользователя из Hive. Применяется это в случае отсутствия интернета
  // Future getFoodInfo() async {
  //   final localUser = _userRepository.localUser;
  //
  //   if (localUser != null) {
  //     final Box<List> foodBox = await Hive.openBox<List>('foodBox');
  //     if (foodBox.isEmpty) {
  //       _userRepository.setFoodList([]);
  //       return;
  //     }
  //     final List<Food> listFood = foodBox.get('foodList')?.cast<Food>() ?? [];
  //     _userRepository.setFoodList(listFood);
  //     await foodBox.close();
  //   }
  // }

  ///Записываем обновлённый список еды пользователя в Hive
  // Future setFoodInfo() async {
  //   final localUser = _userRepository.localUser;
  //
  //   if (localUser != null) {
  //     final Box<List<Food>> foodBox = await Hive.openBox<List<Food>>('foodBox');
  //     await foodBox.put('foodList', localUser.myFoods);
  //     await foodBox.close();
  //   }
  // }

  ///Получение списка еды пользователя в определённую дату
  // Future<
  //     (
  //       List<EatingFood>,
  //       List<EatingFood>,
  //       List<EatingFood>,
  //       List<EatingFood>
  //     )> _getEatingFoodListsByDate(DateTime dateTime) async {
  //   dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
  //   final Box<List> eatingBox = await Hive.openBox<List>('eatingBox');
  //   List<EatingFood> breakfast = [];
  //   List<EatingFood> lunch = [];
  //   List<EatingFood> dinner = [];
  //   List<EatingFood> another = [];
  //   if (eatingBox.isEmpty) {
  //     return (breakfast, lunch, dinner, another);
  //   }
  //   breakfast =
  //       eatingBox.get('breakfast${dateTime.toString()}')?.cast<EatingFood>() ??
  //           [];
  //   lunch =
  //       eatingBox.get('lunch${dateTime.toString()}')?.cast<EatingFood>() ?? [];
  //   dinner =
  //       eatingBox.get('dinner${dateTime.toString()}')?.cast<EatingFood>() ?? [];
  //   another =
  //       eatingBox.get('another${dateTime.toString()}')?.cast<EatingFood>() ??
  //           [];
  //   await eatingBox.close();
  //   return (breakfast, lunch, dinner, another);
  // }

  ///Получение приёмой пищи в текущую дату
  // Future getEatingFoodInfoNow() async {
  //   final localUser = _userRepository.localUser;
  //
  //   if (localUser == null) {
  //     throw 'local равен нулю';
  //   }
  //
  //   if (await _userRepository.isConnected()) {
  //     try {
  //       _userRepository.setEatingFoodListForLocalUser(
  //           await _getEatingFoodListsByDate(DateTime.now()));
  //       return;
  //     } on Exception catch (_) {
  //       print('Ошибка получения списков приёмов пищи с БД');
  //     }
  //   }
  //
  //   final DateTime now = DateTime.now();
  //   final DateTime dateNow = DateTime(now.year, now.month, now.day);
  //   _userRepository.setEatingFoodListForLocalUser(await _getEatingFoodListsByDate(dateNow));
  // }

  ///Пока что будет способ сохранения только на текущую дату
  // Future _setEatingFoodInfoNow() async {
  //   final localUser = _userRepository.localUser;
  //
  //   if (localUser == null) {
  //     throw 'local равен нулю';
  //   }
  //
  //   ///Логика тут ломает ум, поэтому комментарии исключительно для меня
  //
  //   ///Получаем данные о текущей дате
  //   final DateTime now = DateTime.now();
  //   final DateTime dateNow = DateTime(now.year, now.month, now.day);
  //
  //   ///Открываем [eatingBox]
  //   final Box<List> eatingBox = await Hive.openBox<List>('eatingBox');
  //
  //   ///Сохраняем списки со съеденной едой по ключу в формате ["название приёма пищи + дата"]
  //   await eatingBox.put(
  //       'breakfast${dateNow.toString()}', localUser.eatingBreakfast);
  //   await eatingBox.put('lunch${dateNow.toString()}', localUser.eatingLunch);
  //   await eatingBox.put('dinner${dateNow.toString()}', localUser.eatingDinner);
  //   await eatingBox.put(
  //       'another${dateNow.toString()}', localUser.eatingAnother);
  //   await eatingBox.close();
  // }

  ///Удаление еды из списка юзера, НО не из БД
  @override
  Future<bool> deleteFood(Food food) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    try{
      await _database.foodData.deleteFood(food.idFood, localUser.userId);
    }
    catch(_){
      return false;
    }

    final List<Food> listFood = localUser.myFoods;
    listFood.remove(food);
    _userRepository.setFoodList(listFood);

    return true;
  }

  ///Добавление еды в приём пищи
  @override
  Future<(List<EatingFood>, String)> addFoodEatingList(
      String nameEating,
      String idFood,
      String title,
      double protein,
      double fats,
      double carbohydrates,
      double calories,
      int weight) async {

    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    ///Получаем дату на момент получение запроса на добавление еды в приём пищи
    final String dateNow = DateFormat('ddMMyyyy').format(DateTime.now());

    /// Сравниваем [dateNow] и [_dateNow]. Если они не равны, значит наступил новый день
    if(_dateNow != dateNow){
      _dateNow = dateNow;
      await getEatingFoodInfoInFirebase();
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
    await _userRepository.setEatingFoodListForLocalUser((
      localUser.eatingBreakfast,
      localUser.eatingLunch,
      localUser.eatingDinner,
      localUser.eatingAnother
    ));
    await _setEatingInfoInFirebase();
    return (listEatingFood, getCalories(listEatingFood));
  }

  ///Редактирование еды, которая добавлена в список приёма пищи
  @override
  Future<(List<EatingFood>, String)> updateFoodInEatingList(
      String nameEating, int index, int weight) async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    List<EatingFood> listEatingFood = [];

    if (nameEating == 'Завтрак') {
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
    await _userRepository.setEatingFoodListForLocalUser((
      localUser.eatingBreakfast,
      localUser.eatingLunch,
      localUser.eatingDinner,
      localUser.eatingAnother
    ));
    await _setEatingInfoInFirebase();
    return (listEatingFood, getCalories(listEatingFood));
  }

  ///Удаление еды из приёма пищи
  @override
  Future<(List<EatingFood>, String)> deleteFoodInEatingList(
      String nameEating, int index) async {
    final localUser = _userRepository.localUser;

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

    await _userRepository.setEatingFoodListForLocalUser((
      localUser.eatingBreakfast,
        localUser.eatingLunch,
        localUser.eatingDinner,
        localUser.eatingAnother
    ));

    await _setEatingInfoInFirebase();
    return (listEatingFood, getCalories(listEatingFood));
  }

  ///Получение приёма пищи по названию
  @override
  (List<EatingFood>, String) getEatingList(String nameEating) {
    final localUser = _userRepository.localUser;
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

  Future _setEatingInfoInFirebase() async {
    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser равен нулю';
    }

    final DateTime dateNow =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    List<Map<String, dynamic>> eatingBreakfast = [];
    for (EatingFood eatingFood in localUser.eatingBreakfast) {
      eatingBreakfast.add(eatingFood.toJson());
    }
    List<Map<String, dynamic>> eatingLunch = [];
    for (EatingFood eatingFood in localUser.eatingLunch) {
      eatingLunch.add(eatingFood.toJson());
    }
    List<Map<String, dynamic>> eatingDinner = [];
    for (EatingFood eatingFood in localUser.eatingDinner) {
      eatingDinner.add(eatingFood.toJson());
    }
    List<Map<String, dynamic>> eatingAnother = [];
    for (EatingFood eatingFood in localUser.eatingAnother) {
      eatingAnother.add(eatingFood.toJson());
    }

    await _database.foodData.setEatingInfoInFirebase(DateFormat(
        'ddMMyyyy').format(dateNow),
        localUser.userId,
        eatingBreakfast,
        eatingLunch,
        eatingDinner,
        eatingAnother
    );
  }

  @override
  Future<(List<EatingFood>, List<EatingFood>, List<EatingFood>, List<EatingFood>)>
  getEatingFoodInfoInFirebase([DateTime? dateTime]) async {

    final localUser = _userRepository.localUser;

    if (localUser == null) {
      throw 'localUser is null';
    }

    final String dateFormat = dateTime != null
        ? DateFormat('ddMMyyyy').format(dateTime)
        : _dateNow;

    final response = await _database.foodData.getEatingFoodInfoInFirebase(localUser.userId, dateFormat);

    List<EatingFood> breakfast = response.$1;
    List<EatingFood> lunch = response.$2;
    List<EatingFood> dinner = response.$3;
    List<EatingFood> another = response.$4;

    await _userRepository.setEatingFoodListForLocalUser((breakfast, lunch, dinner, another));

    return (breakfast, lunch, dinner, another);
  }

  @override
  String getCalories(List<EatingFood> listEatingFood) {
    double calories = 0;
    for (EatingFood food in listEatingFood) {
      calories += food.calories / 100 * food.weight;
    }
    return calories.toStringAsFixed(2);
  }
}
