import 'package:app1/objects/food.dart';
import 'package:app1/objects/result.dart';
import 'package:firebase_database/firebase_database.dart';

final ref = FirebaseDatabase.instance.ref();

class AppUser // Назвал не User, а AppUser чтобы не было путаницы с классом из библиотеки firebase_database.dart
{
  late String userId;
  String? name;
  String? email;
  List<Food> myFoods = [];
  List<Result> myResults = [];
  //late String urlPhoto;
  AppUser({required this.userId, required this.name, required this.email});

  AppUser.fromJson(Map<String, dynamic> json) :
        name = json['name'],
        email = json['email'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'email': email,
    'userId': userId
  };
}