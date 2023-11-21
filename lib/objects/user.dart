import 'dart:io';

import 'package:app1/objects/food.dart';
import 'package:app1/objects/result.dart';
import 'package:flutter/material.dart';

import 'eatingFood.dart';

///Класс юзера
///Вся работа с юзером происходит в UserService
/// [userId] - id Пользователя
/// [name] - имя Пользователя
/// [email] - почта Пользователя
/// [weightNow] - вес пользователя на данный момент
/// [weightDream] - вес, к которому стремишься
/// [height] - рост
/// [birthday] - дата рождения
/// [age] - возраст(высчитывается)
/// [urlAvatar] - ссылка на аватарку
/// [avatar] - изображение аватарки. Если интернет включен качает с хранилища,
/// если нет интернета, берёт с локального хранилища
/// [myFoods] - список еды пользователя
/// [eatingBreakfast], [eatingLunch], [eatingDinner], [eatingAnother] - список
/// еды в приёмах пищи, хранится локально и обновляется при наступлении нового дня
/// [myResults] ПОКА НЕ РЕАЛИЗОВАН
/// [eatingValues] - показатели съеденных БЖУ и каллорий
///
/// Разные конструкторы(обычный [AppUser], получение из json[AppUser.fromJson])
class AppUser // Назвал не User, а AppUser чтобы не было путаницы с классом из библиотеки firebase_database.dart
{
  late String userId;
  late String name;
  late String email;
  double? weightNow;
  double? weightDream;
  int? height;
  DateTime? birthday;
  int? age;
  String? urlAvatar;
  File? avatar;
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
  AppUser({required this.userId, required this.name, required this.email,
    required this.weightNow, required this.weightDream, required this.height,
    required this.birthday, required this.urlAvatar})
  {
    _countAge();
  }

  AppUser.fromJson(Map<String?, dynamic> json):
        name = json['name'],
        email = json['email'],
        userId = json['userId'],
        urlAvatar = json['urlAvatar'],
        weightNow = json['weightNow'],
        weightDream = json['weightDream'],
        height = json['height'],
        birthday = DateTime.parse(json['birthday'])
  {
    _countAge();
  }

  ///Превращаем в json
  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'email': email,
      'userId': userId,
      'urlAvatar': urlAvatar,
      'weightNow': weightNow,
      'weightDream': weightDream,
      'height': height,
      'birthday': birthday.toString()
    };
  }

  void _countAge(){
    if(birthday != null){
      birthday = DateTime(birthday!.year,birthday!.month,birthday!.day);
      int ageCounter = DateTime.now().year - birthday!.year - 1;
      if(DateTime.now().month - birthday!.month >= 0 && DateTime.now().day - birthday!.day >= 0){
        ageCounter += 1;
      }
      age = ageCounter;
    }
    else{
      age = null;
    }
  }
}