import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/myFoodPage.dart';
import 'package:app1/pages/registrationPage.dart';
import 'package:app1/pages/startPage.dart';
import 'package:app1/pages/myCalories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app1/pages/firstPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///TODO | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ | Сделать валидацию при регистрации
///TODO | Переписать код получения юзера(Чтобы получить его один раз и передавать на другие экраны, а не каждый раз запрашивать заново)



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  //     MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   initialRoute: '/startPage',
  //   routes: {
  //     '/startPage': (context) => const StartPage(), ///TODO это начальный загрузочный экран, поэтому его в конце поставить как initialRoute
  //     '/firstPage': (context) => const FirstPage(),
  //     '/authorizationPage': (context) => const AuthorizationPage(),
  //     '/registrationPage': (context) => const RegistrationPage(),
  //   },
  // ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FoodBloc>(
              create: (BuildContext context) => FoodBloc()
          ),
          BlocProvider<EatingFoodBloc>(
              create: (BuildContext context) => EatingFoodBloc()
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StartPage(),
        ));
  }
}

