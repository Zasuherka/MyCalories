import 'package:app1/objects/food.dart';
import 'package:app1/objects/result.dart';
import 'package:firebase_database/firebase_database.dart';

import 'eatingFood.dart';

final ref = FirebaseDatabase.instance.ref();

class AppUser // Назвал не User, а AppUser чтобы не было путаницы с классом из библиотеки firebase_database.dart
{
  late String userId;
  String? name;
  String? email;
  List<Food> myFoods = [];
  List<EatingFood> eatingBreakfast = [];
  List<EatingFood> eatingLunch = [];
  List<EatingFood> eatingDinner = [];
  List<EatingFood> eatingAnother = [];
  List<Result> myResults = [];
  Map<String, double> eatingValues = {
    'КАЛОРИИ': 0,
    'БЕЛКИ': 0,
    'ЖИРЫ': 0,
    'УГЛЕВОДЫ': 0
  };
  //late String urlPhoto;
  AppUser({required this.userId, required this.name, required this.email});

  AppUser.fromJson(Map<String, dynamic> json):
        name = json['name'],
        email = json['email'],
        userId = json['userId'];

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'email': email,
      'userId': userId
    };
  }
}