import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/myFoodPage.dart';
import 'package:app1/pages/registrationPage.dart';
import 'package:app1/widgets/myCalories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app1/pages/firstPage.dart';

///TODO | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ | Сделать валидацию при регистрации
///TODO | Переписать код получения юзера(Чтобы получить его один раз и передавать на другие экраны, а не каждый раз запрашивать заново)



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('Сервак запустился');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/startPage',
    routes: {
      '/myFoodPage': (context) => const MyFoodPage(),
      '/startPage': (context) => const MyCalories(), ///TODO это начальный загрузочный экран, поэтому его в конце поставить как initialRoute
      '/firstPage': (context) => const FirstPage(),
      '/authorizationPage': (context) => const AuthorizationPage(),
      '/registrationPage': (context) => const RegistrationPage(),
    },
  ));
}

