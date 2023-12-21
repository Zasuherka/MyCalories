import 'package:app1/bloc/authorization/authorization_bloc.dart';
import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/bloc/registration/registration_bloc.dart';
import 'package:app1/bloc/userImage/user_image_bloc.dart';
import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/enums/sex.dart';
import 'package:app1/objects/eatingFood.dart';
import 'package:app1/objects/food.dart';
import 'package:app1/objects/user.dart';
import 'package:app1/pages/startPage.dart';
import 'package:app1/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

///TODO | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ | Сделать валидацию при регистрации |
///TODO Сделать везде проверку на инет и вылет окна ошибки(Делать с помощью структуру
///TODO try catch(throw))
///TODO При редакстировании еды, создаётся новая или нет(нужно потестить и разобраться)


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(0)){
    Hive.registerAdapter(AppUserAdapter());
  }
  if(!Hive.isAdapterRegistered(1)){
    Hive.registerAdapter(FoodAdapter());
  }
  if(!Hive.isAdapterRegistered(2)){
    Hive.registerAdapter(EatingFoodAdapter());
  }
  if(!Hive.isAdapterRegistered(3)){
    Hive.registerAdapter(SexAdapter());
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    addScreenSize(context);
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
          ),
          BlocProvider<AuthorizationBloc>(
              create: (BuildContext context) => AuthorizationBloc()
          ),
          BlocProvider<RegistrationBloc>(
              create: (BuildContext context) => RegistrationBloc()
          )
        ],
        child: MaterialApp(
          theme: createTheme(),
          debugShowCheckedModeBanner: false,
          home: const StartPage(),
        ));
  }
}

