import 'dart:async';
import 'package:app1/objects/food.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:app1/objects/eatingFood.dart';


///Создание Еды, запись в БД, запись в список еды пользователя
Future<List<Food>?> createFood(String title, String protein, String fats, String carbohydrates, String calories) async
{
  if(await isConnected() && localUser != null){
    DatabaseReference ref = FirebaseDatabase.instance.ref("/foods");
    try {
      final food = ref.push();
      await food.set({
        "authorEmail": localUser!.email,
        "title": title,
        "lowerCaseTitle": title.toLowerCase(),
        "protein": double.parse(protein).toStringAsFixed(2),
        "fats": double.parse(fats).toStringAsFixed(2),
        "carbohydrates":double.parse(carbohydrates).toStringAsFixed(2),
        "calories": double.parse(calories).toStringAsFixed(2)
      });
      final Food newFood = Food(food.key.toString(), localUser!.email, title, double.parse(protein), double.parse(fats), double.parse(carbohydrates), double.parse(calories));
      newFood.isUserFood = true;
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
      return localUser!.myFoods;
    }
    catch (e) {
      print("Ошибка" + e.toString());
    }
  }
  return null;
}

///Обновление информации о еде в БД и в списке
Future<List<Food>?> updateFood(Food food, String title, String protein, String fats, String carbohydrates, String calories) async
{
  final String idFood = food.idFood;
  if (await isConnected() && localUser != null){
    final ref = FirebaseDatabase.instance.ref("/foods/$idFood");
    try {
      await ref.update({
        "title": title,
        "lowerCaseTitle": title.toLowerCase(),
        "protein": double.parse(protein).toStringAsFixed(2),
        "fats": double.parse(fats).toStringAsFixed(2),
        "carbohydrates":double.parse(carbohydrates).toStringAsFixed(2),
        "calories": double.parse(calories).toStringAsFixed(2)
      });
      final int index = localUser!.myFoods.indexOf(food);
      final Food updateFood = Food(idFood, localUser!.email, title,double.parse(protein),double.parse(fats),double.parse(carbohydrates),double.parse(calories));
      updateFood.isUserFood = true;
      localUser!.myFoods[index] = updateFood;
      await setFoodInfo();
      return localUser!.myFoods;
    }
    catch (e) {
      throw "Ошибка обновления $e";
    }
  }
  return null;
}

Future<List<Food>> findFood(String searchText) async {
  if (localUser == null){
    throw 'User is null';
  }
  if(searchText == ''){
    return localUser!.myFoods;
  }
  if (localUser!.myFoods.isEmpty) {
    return [];
  }
  if (searchText == ' ') {
    return [];
  }
  List<Food> findFoodList = [];
  for (Food food in localUser!.myFoods) {
    if (food.title.toLowerCase().contains(searchText.toLowerCase())){
      findFoodList.add(food);
    }
  }
  return findFoodList;
}

Future<List<Food>> findGlobalFood(String searchText) async {
  if (localUser == null){
    throw 'User is null';
  }
  if (searchText == ' ' || searchText == '') {
    return [];
  }
  List<Food> findGlobalFoodList = [];
  final DatabaseReference foodsRef = FirebaseDatabase.instance.ref('foods');
  final Query query = foodsRef.orderByChild('lowerCaseTitle').startAt(searchText.toLowerCase()).endAt('${searchText.toLowerCase()}\uf8ff');
  try {
    DatabaseEvent snapshot = await query.once();
    for (DataSnapshot snapshotFood in snapshot.snapshot.children){
      final Food findFood = Food(
          snapshotFood.key.toString(),snapshotFood.child('authorEmail').value.toString(),
          snapshotFood.child('title').value.toString(),
          double.parse(snapshotFood.child('protein').value.toString()),
          double.parse(snapshotFood.child('fats').value.toString()),
          double.parse(snapshotFood.child('carbohydrates').value.toString()),
          double.parse(snapshotFood.child('calories').value.toString())
      );
      if(localUser!.email == findFood.authorEmail){
        findFood.isUserFood = true;
      }
      else{
        findFood.isUserFood = false;
      }
      findFood.isThisFoodOnTheMyFoodList = false;
      findGlobalFoodList.add(findFood);
      ///TODO в список глобальной еды зачем-то кидает еду пользователя(возможно нужно
      ///откатиться)

      for (Food food in localUser!.myFoods){
        if (findFood.idFood == food.idFood){
          findGlobalFoodList.remove(findFood);
        }
      }
    }
  }
  catch (error){
    print('error: ' + error.toString());
  }
  return findGlobalFoodList;
}

Future<List<Food>> addingFood(Food food) async{
  if(localUser != null){
    try{
      DatabaseReference ref = FirebaseDatabase.instance.ref("/users/${localUser!.userId}");
      DataSnapshot listFoods = await ref.child('myFoods').get();
      if(listFoods.value == null){
        await ref.update({
          "myFoods": [food.idFood]
        });
      }
      else{
        List newListFood = [];
        for (var food in listFoods.children) {
          newListFood.add(food.value.toString());
        }
        newListFood.add(food.idFood);
        await ref.update({
          "myFoods": newListFood
        });
      }
      food.isThisFoodOnTheMyFoodList = true;
      localUser!.myFoods.add(food);
      await setFoodInfo();
      return localUser!.myFoods;
    }
    catch (error){
      print('error: ' + error.toString());
    }
  }
  throw 'localUser равен нулю';
}

///Получение еды в локальный список пользователя
Future<void> getUserFoods() async
{
  if(localUser == null){
    throw 'localUser равен нулю';
  }
  localUser!.myFoods = [];
  if(await isConnected()){
    try
    {
      DatabaseReference ref = FirebaseDatabase.instance.ref('users/${localUser!.userId}/myFoods');
      DataSnapshot listFoods = await ref.get();
      for(DataSnapshot food in listFoods.children){
        ref = FirebaseDatabase.instance.ref('foods/${food.value}');
        DataSnapshot getFood = await ref.get();
        final Food newFood = Food(
            food.value.toString(),getFood.child('authorEmail').value.toString(),
            getFood.child('title').value.toString(),
            double.parse(getFood.child('protein').value.toString()),
            double.parse(getFood.child('fats').value.toString()),
            double.parse(getFood.child('carbohydrates').value.toString()),
            double.parse(getFood.child('calories').value.toString())
        );
        if(localUser!.email == newFood.authorEmail){
          newFood.isUserFood = true;
        }
        else{
          newFood.isUserFood = false;
        }
        newFood.isThisFoodOnTheMyFoodList = true;
        if(!localUser!.myFoods.contains(newFood)){
          localUser!.myFoods.add(newFood);
        }
      }
      await setFoodInfo();
    }
    catch (e){
      print('reading error: $e');
      await getFoodInfo();
    }
  } else{
    await getFoodInfo();
  }


}


///Получаем [localUser] из Hive
Future getFoodInfo() async {
  if(localUser != null){
    final Box<List> foodBox = await Hive.openBox<List>('foodBox');
    if(foodBox.isEmpty){
      localUser!.myFoods = [];
      return;
    }
    final List<Food> foodList = foodBox.get('foodList')?.cast<Food>() ?? [];
    localUser!.myFoods = foodList;
    await foodBox.close();
  }
}

///Записываем [localUser] в Hive
Future setFoodInfo() async {
  if(localUser != null){
    final Box<List<Food>> foodBox = await Hive.openBox<List<Food>>('foodBox');
    await foodBox.put('foodList', localUser!.myFoods);
    await foodBox.close();
  }
}

Future<(List<EatingFood>,List<EatingFood>,List<EatingFood>,List<EatingFood>)> getEatingFoodListsByDate(DateTime dateTime) async{
  dateTime = DateTime(dateTime.year,dateTime.month,dateTime.day);
  final Box<List> eatingBox = await Hive.openBox<List>('eatingBox');
  List<EatingFood> breakfast = [];
  List<EatingFood> lunch = [];
  List<EatingFood> dinner = [];
  List<EatingFood> another = [];
  if(eatingBox.isEmpty){
    return (breakfast,lunch,dinner,another);
  }

  breakfast = eatingBox.get('breakfast${dateTime.toString()}')?.cast<EatingFood>() ?? [];
  lunch = eatingBox.get('lunch${dateTime.toString()}')?.cast<EatingFood>() ?? [];
  dinner = eatingBox.get('dinner${dateTime.toString()}')?.cast<EatingFood>() ?? [];
  another = eatingBox.get('another${dateTime.toString()}')?.cast<EatingFood>() ?? [];
  await eatingBox.close();
  return (breakfast,lunch,dinner,another);
}


///Ещё не начинал переписывать
Future<void> getEatingFoodInfoNow() async {
  final DateTime now = DateTime.now();
  final DateTime dateNow = DateTime(now.year, now.month, now.day);
  final (List<EatingFood>,List<EatingFood>,List<EatingFood>,List<EatingFood>) eatingFoodLists = await getEatingFoodListsByDate(dateNow);
  localUser!.eatingBreakfast = eatingFoodLists.$1;
  localUser!.eatingLunch = eatingFoodLists.$2;
  localUser!.eatingDinner = eatingFoodLists.$3;
  localUser!.eatingAnother = eatingFoodLists.$4;
}

///Пока что будет способ сохранения только на текущую дату
Future<void> setEatingFoodInfoNow() async {

  ///Логика тут ломает ум, поэтому комментарии исключительно для меня

  ///Получаем данные о текущей дате
  DateTime now = DateTime.now();
  DateTime dateNow = DateTime(now.year, now.month, now.day);
  ///Открываем [eatingBox]
  final Box<List> eatingBox = await Hive.openBox<List>('eatingBox');

  ///Сохраняем списки со съеденной едой по ключу в формате ["название приёма пищи + дата"]
  await eatingBox.put('breakfast${dateNow.toString()}', localUser!.eatingBreakfast);
  await eatingBox.put('lunch${dateNow.toString()}', localUser!.eatingLunch);
  await eatingBox.put('dinner${dateNow.toString()}', localUser!.eatingDinner);
  await eatingBox.put('another${dateNow.toString()}', localUser!.eatingAnother);

  await eatingBox.close();
}


///Удаление еды из списка юзера, НО не из БД
Future<bool> deleteFood(Food food) async
{
  final String idFood = food.idFood;
  localUser!.myFoods.remove(food);
  if(await isConnected()){
    DatabaseReference ref = FirebaseDatabase.instance.ref("/users/${localUser!.userId}");
    DataSnapshot listFoods = await ref.child('myFoods').get();
    List newListFood = [];
    for (var food in listFoods.children) {
      newListFood.add(food.value.toString());
    }
    newListFood.remove(idFood);
    try {
      await ref.update({
        "myFoods": newListFood
      });
    }
    catch(error) {
      throw 'delete food error: $error';
    }
    await setFoodInfo();
    return true;
  }
  return false;
}


(List<EatingFood>, String) addFoodEatingList(String nameEating, String idFood,   String title,   double protein,   double fats,   double carbohydrates,   double calories,   int weight){
  if(localUser != null){
    protein = (protein / 100 * weight);
    fats = fats / 100 * weight;
    carbohydrates = carbohydrates / 100 * weight;
    calories = calories / 100 * weight;
    final EatingFood eatingFood = EatingFood(idFood, localUser!.email, title,protein,fats,carbohydrates,calories,weight);
    if (nameEating == 'Завтрак'){
      localUser!.eatingBreakfast.add(eatingFood);
      return (localUser!.eatingBreakfast, getCalories(localUser!.eatingBreakfast));
    }
    if (nameEating == 'Обед'){
      localUser!.eatingLunch.add(eatingFood);
      return (localUser!.eatingLunch, getCalories(localUser!.eatingLunch));
    }
    if (nameEating == 'Ужин'){
      localUser!.eatingDinner.add(eatingFood);
      return (localUser!.eatingDinner, getCalories(localUser!.eatingDinner));
    }
    localUser!.eatingAnother.add(eatingFood);
    return (localUser!.eatingAnother, getCalories(localUser!.eatingAnother));
  }
  throw 'localUser равен нулю';
}

Future<(List<EatingFood>, String)> updateFoodInEatingList(String nameEating, int index, int weight) async {
  if(localUser == null){
    throw 'localUser равен нулю';
  }
  print(nameEating);
  if (nameEating == 'Завтрак'){
    final int oldWeight = localUser!.eatingBreakfast[index].weight;
    localUser!.eatingBreakfast[index].weight = weight;
    localUser!.eatingBreakfast[index].protein = localUser!.eatingBreakfast[index].protein / oldWeight * weight;
    localUser!.eatingBreakfast[index].fats = localUser!.eatingBreakfast[index].fats / oldWeight * weight;
    localUser!.eatingBreakfast[index].carbohydrates = localUser!.eatingBreakfast[index].carbohydrates / oldWeight * weight;
    localUser!.eatingBreakfast[index].calories = localUser!.eatingBreakfast[index].calories / oldWeight * weight;
    return (localUser!.eatingBreakfast, getCalories(localUser!.eatingBreakfast));
  }
  if (nameEating == 'Обед'){
    final int oldWeight = localUser!.eatingLunch[index].weight;
    localUser!.eatingLunch[index].weight = weight;
    localUser!.eatingLunch[index].protein = localUser!.eatingLunch[index].protein / oldWeight * weight;
    localUser!.eatingLunch[index].fats = localUser!.eatingLunch[index].fats / oldWeight * weight;
    localUser!.eatingLunch[index].carbohydrates = localUser!.eatingLunch[index].carbohydrates / oldWeight * weight;
    localUser!.eatingLunch[index].calories = localUser!.eatingLunch[index].calories / oldWeight * weight;
    return (localUser!.eatingLunch, getCalories(localUser!.eatingLunch));
  }
  if (nameEating == 'Ужин'){
    final int oldWeight = localUser!.eatingDinner[index].weight;
    localUser!.eatingDinner[index].weight = weight;
    localUser!.eatingDinner[index].protein = localUser!.eatingDinner[index].protein / oldWeight * weight;
    localUser!.eatingDinner[index].fats = localUser!.eatingDinner[index].fats / oldWeight * weight;
    localUser!.eatingDinner[index].carbohydrates = localUser!.eatingDinner[index].carbohydrates / oldWeight * weight;
    localUser!.eatingDinner[index].calories = localUser!.eatingDinner[index].calories / oldWeight * weight;
    return (localUser!.eatingDinner, getCalories(localUser!.eatingDinner));
  }
  final int oldWeight = localUser!.eatingAnother[index].weight;
  localUser!.eatingAnother[index].weight = weight;
  localUser!.eatingAnother[index].protein = localUser!.eatingAnother[index].protein / oldWeight * weight;
  localUser!.eatingAnother[index].fats = localUser!.eatingAnother[index].fats / oldWeight * weight;
  localUser!.eatingAnother[index].carbohydrates = localUser!.eatingAnother[index].carbohydrates / oldWeight * weight;
  localUser!.eatingAnother[index].calories = localUser!.eatingAnother[index].calories / oldWeight * weight;
  return (localUser!.eatingAnother, getCalories(localUser!.eatingAnother));
}

(List<EatingFood>, String) deleteFoodInEatingList(String nameEating, int index) {
  if(localUser != null){
    if (nameEating == 'Завтрак'){
      localUser!.eatingBreakfast.removeAt(index);
      return (localUser!.eatingBreakfast, getCalories(localUser!.eatingBreakfast));
    }
    if (nameEating == 'Обед'){
      localUser!.eatingLunch.removeAt(index);
      return (localUser!.eatingLunch, getCalories(localUser!.eatingLunch));
    }
    if (nameEating == 'Ужин'){
      localUser!.eatingDinner.removeAt(index);
      return (localUser!.eatingDinner, getCalories(localUser!.eatingDinner));
    }
    localUser!.eatingAnother.removeAt(index);
    return (localUser!.eatingAnother, getCalories(localUser!.eatingAnother));
  }
  throw 'localUser равен нулю';
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