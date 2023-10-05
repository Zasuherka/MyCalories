import 'dart:convert';

import 'package:app1/objects/food.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';



///Создание Еды, запись в БД, запись в список еды пользователя
Future createFood(String title, String protein, String fats, String carbohydrates, String calories) async
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
      localUser!.myFoods.add(Food(food.key.toString(), title, protein, fats, carbohydrates, calories));
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
    }
    catch (e) {
      print("Ошибка" + e.toString());
    }
  }
}

///Обновление информации о еде в БД и в списке
Future<void> updateFood(Food food, String idFood, String title, String protein, String fats, String carbohydrates, String calories) async
{
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
      localUser!.myFoods[index] = Food(idFood,title,protein,fats,carbohydrates,calories);
      await setFoodInfo();
    }
    catch (e) {
      print("Ошибка" + e.toString());
    }
  }
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
        final Food newFood = Food(food.value.toString(),getFood.child('title').value.toString(),getFood.child('protein').value.toString(),
            getFood.child('fats').value.toString(),getFood.child('carbohydrates').value.toString(), getFood.child('calories').value.toString());
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
  //List<Map<String, dynamic>> foodJsonList = localUser!.myFoods.map((food) => food.toJson()).toList();
  await prefs.setStringList('foodInfo', localUser!.myFoods.map((food) => jsonEncode(food)).toList());
}

///Удаление еды из списка юзера, НО не из БД
Future<void> deleteFood(Food food, String foodId) async
{
  localUser!.myFoods.remove(food);
  if(await isConnected()){
    DatabaseReference ref = FirebaseDatabase.instance.ref("/users/${localUser!.userId}");
    DataSnapshot listFoods = await ref.child('myFoods').get();
    List newListFood = [];
    for (var food in listFoods.children) {
      newListFood.add(food.value.toString());
    }
    newListFood.remove(foodId);
    await ref.update({
      "myFoods": newListFood
    });
    await setFoodInfo();
  }
}
