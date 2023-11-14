import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/bloc/userImage/user_image_bloc.dart';
import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/pages/startPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///TODO | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ | Сделать валидацию при регистрации |
///TODO Сделать везде проверку на инет и вылет окна ошибки(Делать с помощью структуру
///TODO try catch(throw))


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
          ),
          BlocProvider<UserImageBloc>(
              create: (BuildContext context) => UserImageBloc()
          ),
          BlocProvider<UserInfoBloc>(
              create: (BuildContext context) => UserInfoBloc()
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StartPage(),
        ));
  }
}

