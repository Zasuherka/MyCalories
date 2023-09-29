import 'package:app1/objects/food.dart';
import 'package:app1/objects/user.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


///TODO разобраться почему не все данные подгружаются
Future createFood(String title, String protein, String fats, String carbohydrates, String calories) async
{
  DatabaseReference ref = FirebaseDatabase.instance.ref("/foods");
  try {
    final food = ref.push();
    await food.set({
      "authorEmail": localUser.email,
      "title": title,
      "protein": double.parse(protein).toStringAsFixed(2),
      "fats": double.parse(fats).toStringAsFixed(2),
      "carbohydrates":double.parse(carbohydrates).toStringAsFixed(2),
      "calories": double.parse(calories).toStringAsFixed(2)
    });

    ref = FirebaseDatabase.instance.ref("/users/${localUser.userId}");

    DataSnapshot listFoods = await ref.child('myFoods').get();

    if(listFoods.value == null){
      await ref.update({
        "myFoods": [food.key]
      });
    }
    else{
      List newListFood = [];
      listFoods.children.forEach((food) {
        newListFood.add(food.value.toString());
      });
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

Future<void> updateFood(String idFood, String title, String protein, String fats, String carbohydrates, String calories) async
{
  final ref = FirebaseDatabase.instance.ref("/foods/$idFood");
  try {
    await ref.update({
      "title": title,
      "protein": double.parse(protein).toStringAsFixed(2),
      "fats": double.parse(fats).toStringAsFixed(2),
      "carbohydrates":double.parse(carbohydrates).toStringAsFixed(2),
      "calories": double.parse(calories).toStringAsFixed(2)
    });
  }
  catch (e) {
    print("Ошибка" + e.toString());
  }
}

/// TODO обновить способ получения продуктов пользователя. Сделать с помощью списка айдишников еды
Stream<List<Food>> getUserFoods() async*
{
  List<Food> userFoods = [];
  try
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref('users/${localUser.userId}/myFoods');
    DataSnapshot listFoods = await ref.get();
    for(DataSnapshot food in listFoods.children){
      ref = FirebaseDatabase.instance.ref('foods/${food.value}');
      DataSnapshot getFood = await ref.get();
      userFoods.add(Food(food.value.toString(),getFood.child('title').value.toString(),getFood.child('protein').value.toString(),
          getFood.child('fats').value.toString(),getFood.child('carbohydrates').value.toString(), getFood.child('calories').value.toString()));
    }
  }
  catch(e)
  {
    print("Error: " + e.toString());
  }
  yield userFoods;
}

Future<void> deleteFood(String foodId) async
{
  DatabaseReference ref = FirebaseDatabase.instance.ref("/users/${localUser.userId}");
  DataSnapshot listFoods = await ref.child('myFoods').get();
  List newListFood = [];
  listFoods.children.forEach((food) {
    newListFood.add(food.value.toString());
  });
  newListFood.remove(foodId);
  await ref.update({
    "myFoods": newListFood
  });
}
