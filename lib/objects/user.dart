import 'package:app1/objects/food.dart';
import 'package:app1/objects/result.dart';
import 'package:firebase_database/firebase_database.dart';

final ref = FirebaseDatabase.instance.ref();

class AppUser // Назвал не User, а AppUser чтобы не было путаницы с классом из библиотеки firebase_database.dart
{
  late String userId;
  String? name;
  String? email;
  List<int> myFoods = [];
  List<Result> myResults = [];
  //late String urlPhoto;
  AppUser(this.userId, this.name, this.email);

  void addMyResults(int weight)
  {

  }


  void getInfoUser()
  {
    getMyFoods();
    getMyResults();
  }

  void getMyFoods()
  {
    ///TODO Реализовать запрос в БД, который будет выдавать список продуктов, у которых authorId = userId
    print(ref.child('/users/$userId/userName').get());
    //myFoods = foods;
  }

  void getMyResults()
  {

  }




}