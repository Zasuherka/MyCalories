import 'package:app1/objects/food.dart';
import 'package:app1/objects/user.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


///TODO разобраться почему не все данные подгружаются
Future<void> addNewFood(String title, String protein, String fats, String carbohydrates, String calories) async
{
  AppUser user = await getAppUser();
  final ref = FirebaseDatabase.instance.ref("/foods");
  try {
    ///TODO дописать правильную запись данных при регистрации
    await ref.push().set({
      "authorId": user.userId,
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

Stream<List<Food>> getUserFoods() async*
{
  List<Food> userFoods = [];
  AppUser user = await getAppUser();
  String title = '';
  String protein = '';
  String fats = '';
  String carbohydrates = '';
  String calories = '';
  try
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref('foods');
    DataSnapshot foods = await ref.orderByChild('authorId').equalTo(user.userId).get();
    foods.children.forEach((food) {
      title = food.child('title').value.toString();
      protein = food.child('protein').value.toString();
      fats = food.child('fats').value.toString();
      carbohydrates = food.child('carbohydrates').value.toString();
      calories = food.child('calories').value.toString();
      userFoods.add(Food(title,protein,fats,carbohydrates, calories));
    });
  }
  catch(e)
  {
    print("Error: " + e.toString());
  }
  yield userFoods;
}

// Future<void> addNewFood2(String foodTitle, String protien, String fats, String carbohydrates) async
// {
//
// }
