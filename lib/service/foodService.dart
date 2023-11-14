import 'dart:convert';
import 'package:app1/objects/food.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app1/objects/eatingFood.dart';


String? isFood;
///Создание Еды, запись в БД, запись в список еды пользователя
Future<Food?> createFood(String title, String protein, String fats, String carbohydrates, String calories) async
{
  if(await isConnected()){
    DatabaseReference ref = FirebaseDatabase.instance.ref("/foods");
    try {
      final food = ref.push();
      await food.set({
        "authorEmail": localUser!.email,
        "title": title,
        "protein": double.parse(protein).toStringAsFixed(2),
        "fats": double.parse(fats).toStringAsFixed(2),
        "carbohydrates":double.parse(carbohydrates).toStringAsFixed(2),
        "calories": double.parse(calories).toStringAsFixed(2)
      });
      final Food newFood = Food(food.key.toString(), title, double.parse(protein), double.parse(fats), double.parse(carbohydrates), double.parse(calories));
      localUser!.myFoods.add(newFood);
      await setFoodInfo();
      ref = FirebaseDatabase.instance.ref("/users/${localUser!.userId}");
      DataSnapshot listFoods = await ref.child('myFoods').get();
      if(listFoods.value == null){
        await ref.update({
          "myFoods": [food.key]
        });
      }
      else{
        List newListFood = [];
        for (var food in listFoods.children) {
          newListFood.add(food.value.toString());
        }
        newListFood.add(food.key);
        await ref.update({
          "myFoods": newListFood
        });
      }
      return newFood;
    }
    catch (e) {
      print("Ошибка" + e.toString());
    }
  }
  return null;
}

///Обновление информации о еде в БД и в списке
Future<Food?> updateFood(Food food, String title, String protein, String fats, String carbohydrates, String calories) async
{
  final String idFood = food.idFood;
  if (await isConnected()){
    final ref = FirebaseDatabase.instance.ref("/foods/$idFood");
    try {
      await ref.update({
        "title": title,
        "protein": double.parse(protein).toStringAsFixed(2),
        "fats": double.parse(fats).toStringAsFixed(2),
        "carbohydrates":double.parse(carbohydrates).toStringAsFixed(2),
        "calories": double.parse(calories).toStringAsFixed(2)
      });
      final int index = localUser!.myFoods.indexOf(food);
      final Food updateFood = Food(idFood,title,double.parse(protein),double.parse(fats),double.parse(carbohydrates),double.parse(calories));
      localUser!.myFoods[index] = updateFood;
      await setFoodInfo();
      return updateFood;
    }
    catch (e) {
      print("Ошибка" + e.toString());
    }
  }
  return null;
}

Future<List<Food>> findFood(String searchText) async {
  if (localUser == null){
    throw 'User is null';
  }
  if (localUser!.myFoods.isEmpty) {
    return [];
  }
  if (searchText == ' ') {
    return [];
  }
  List<Food> findFoodList = [];
  for (var food in localUser!.myFoods) {
    if (food.title.toLowerCase().contains(searchText.toLowerCase())){
      findFoodList.add(food);
    }
  }
  return findFoodList;
}


///Получение еды в локальный список пользователя
Future<void> getUserFoods() async
{
  localUser!.myFoods = [];

  if(await isConnected()){
    try
    {
      DatabaseReference ref = FirebaseDatabase.instance.ref('users/${localUser!.userId}/myFoods');
      DataSnapshot listFoods = await ref.get();
      for(DataSnapshot food in listFoods.children){
        ref = FirebaseDatabase.instance.ref('foods/${food.value}');
        DataSnapshot getFood = await ref.get();
        final Food newFood = Food(food.value.toString(),getFood.child('title').value.toString(),double.parse(getFood.child('protein').value.toString()),
            double.parse(getFood.child('fats').value.toString()),double.parse(getFood.child('carbohydrates').value.toString()), double.parse(getFood.child('calories').value.toString()));
        if(!localUser!.myFoods.contains(newFood)){
          localUser!.myFoods.add(newFood);
        }
      }
      await setFoodInfo();
    }
    catch (e){
      await getFoodInfo();
    }
  } else{
    await getFoodInfo();
  }


}

Future<void> getFoodInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> foodJsonList = prefs.getStringList('foodInfo') ?? [];
  localUser!.myFoods = foodJsonList.map((food) => Food.fromJson(json.decode(food))).toList();
}

Future<void> setFoodInfo() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('foodInfo', localUser!.myFoods.map((food) => jsonEncode(food)).toList());
}

Future<void> getEatingFoodInfo() async {
  DateTime now = DateTime.now();
  DateTime dateNow = DateTime(now.year, now.month, now.day);
  final prefs = await SharedPreferences.getInstance();
  String? getDateInfo = prefs.getString('dateInfo');
  if(getDateInfo == null || DateTime.parse(getDateInfo) != dateNow){
    localUser!.eatingBreakfast = [];
    localUser!.eatingLunch = [];
    localUser!.eatingDinner = [];
    localUser!.eatingAnother = [];
    setEatingFoodInfo();
  } else{
    final List<String> eatingBreakfastJsonList = prefs.getStringList('eatingBreakfastInfo') ?? [];
    final List<String> eatingLunchJsonList = prefs.getStringList('eatingLunchInfo') ?? [];
    final List<String> eatingDinnerJsonList = prefs.getStringList('eatingDinnerInfo') ?? [];
    final List<String> eatingAnotherJsonList = prefs.getStringList('eatingAnotherInfo') ?? [];
    localUser!.eatingBreakfast = eatingBreakfastJsonList.map((food) => EatingFood.fromJson(json.decode(food))).toList();
    localUser!.eatingLunch = eatingLunchJsonList.map((food) => EatingFood.fromJson(json.decode(food))).toList();
    localUser!.eatingDinner = eatingDinnerJsonList.map((food) => EatingFood.fromJson(json.decode(food))).toList();
    localUser!.eatingAnother = eatingAnotherJsonList.map((food) => EatingFood.fromJson(json.decode(food))).toList();
  }

}

Future<void> setEatingFoodInfo() async {
  DateTime now = DateTime.now();
  DateTime dateNow = DateTime(now.year, now.month, now.day);
  final prefs = await SharedPreferences.getInstance();
  String? getDateInfo = prefs.getString('dateInfo');
  if(getDateInfo == null || DateTime.parse(getDateInfo) != dateNow){
    localUser!.eatingBreakfast = [];
    localUser!.eatingLunch = [];
    localUser!.eatingDinner = [];
    localUser!.eatingAnother = [];
  }
  await prefs.setString('dateInfo', dateNow.toString());
  await prefs.setStringList('eatingBreakfastInfo', localUser!.eatingBreakfast.map((food) => jsonEncode(food)).toList());
  await prefs.setStringList('eatingLunchInfo', localUser!.eatingLunch.map((food) => jsonEncode(food)).toList());
  await prefs.setStringList('eatingDinnerInfo', localUser!.eatingDinner.map((food) => jsonEncode(food)).toList());
  await prefs.setStringList('eatingAnotherInfo', localUser!.eatingAnother.map((food) => jsonEncode(food)).toList());
}

///Удаление еды из списка юзера, НО не из БД
Future<bool> deleteFood(Food food) async
{
  final String idFood = food.idFood;
  localUser!.myFoods.remove(food);
  if(await isConnected()){
    try{
      DatabaseReference ref = FirebaseDatabase.instance.ref("/users/${localUser!.userId}");
      DataSnapshot listFoods = await ref.child('myFoods').get();
      List newListFood = [];
      for (var food in listFoods.children) {
        newListFood.add(food.value.toString());
      }
      newListFood.remove(idFood);
      await ref.update({
        "myFoods": newListFood
      });
      await setFoodInfo();
      return true;
    }
    catch (e){
      print(e.toString());
    }
  }
  return false;
}


(List<EatingFood>, String) addFoodEatingList(String idFood,   String title,   double protein,   double fats,   double carbohydrates,   double calories,   int weight){
  protein = (protein / 100 * weight);
  fats = fats / 100 * weight;
  carbohydrates = carbohydrates / 100 * weight;
  calories = calories / 100 * weight;
  final EatingFood eatingFood = EatingFood(idFood,title,protein,fats,carbohydrates,calories,weight);
  if (isFood == 'Завтрак'){
    localUser!.eatingBreakfast.add(eatingFood);
    return (localUser!.eatingBreakfast, getCalories(localUser!.eatingBreakfast));
  }
  if (isFood == 'Обед'){
    localUser!.eatingLunch.add(eatingFood);
    return (localUser!.eatingLunch, getCalories(localUser!.eatingLunch));
  }
  if (isFood == 'Ужин'){
    localUser!.eatingDinner.add(eatingFood);
    return (localUser!.eatingDinner, getCalories(localUser!.eatingDinner));
  }
  localUser!.eatingAnother.add(eatingFood);
  return (localUser!.eatingAnother, getCalories(localUser!.eatingAnother));
}

(List<EatingFood>, String) getEatingList(String nameEating){
  if (nameEating == 'Завтрак'){
    return (localUser!.eatingBreakfast, getCalories(localUser!.eatingBreakfast));
  }
  if (nameEating == 'Обед'){
    return (localUser!.eatingLunch, getCalories(localUser!.eatingLunch));
  }
  if (nameEating == 'Ужин'){
    return (localUser!.eatingDinner, getCalories(localUser!.eatingDinner));
  }
  return (localUser!.eatingAnother, getCalories(localUser!.eatingAnother));
}

String getCalories(List<EatingFood> eatingFood){
  double calories = 0;
  for(EatingFood food in eatingFood){
    calories += food.calories;
  }
  return calories.toStringAsFixed(2);
}

Future<void> getCount() async {
  localUser!.eatingValues['КАЛОРИИ'] = caloriesCounter();
  localUser!.eatingValues['БЕЛКИ'] = proteinCounter();
  localUser!.eatingValues['ЖИРЫ'] = fatsCounter();
  localUser!.eatingValues['УГЛЕВОДЫ'] = carbohydratesCounter();
}

double caloriesCounter() {
  double counter = 0;
  for (var food in localUser!.eatingBreakfast) {
    counter += food.calories;
  }
  for (var food in localUser!.eatingLunch) {
    counter += food.calories;
  }
  for (var food in localUser!.eatingDinner) {
    counter += food.calories;
  }
  for (var food in localUser!.eatingAnother) {
    counter += food.calories;
  }
  return counter;
}


double proteinCounter() {
  double counter = 0;
  for (var food in localUser!.eatingBreakfast) {
    counter += food.protein;
  }
  for (var food in localUser!.eatingLunch) {
    counter += food.protein;
  }
  for (var food in localUser!.eatingDinner) {
    counter += food.protein;
  }
  for (var food in localUser!.eatingAnother) {
    counter += food.protein;
  }
  return counter;
}

double fatsCounter() {
  double counter = 0;
  for (var food in localUser!.eatingBreakfast) {
    counter += food.fats;
  }
  for (var food in localUser!.eatingLunch) {
    counter += food.fats;
  }
  for (var food in localUser!.eatingDinner) {
    counter += food.fats;
  }
  for (var food in localUser!.eatingAnother) {
    counter += food.fats;
  }
  return counter;
}


double carbohydratesCounter() {
  double counter = 0;
  for (var food in localUser!.eatingBreakfast) {
    counter += food.carbohydrates;
  }
  for (var food in localUser!.eatingLunch) {
    counter += food.carbohydrates;
  }
  for (var food in localUser!.eatingDinner) {
    counter += food.carbohydrates;
  }
  for (var food in localUser!.eatingAnother) {
    counter += food.carbohydrates;
  }
  return counter;
}