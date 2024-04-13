import 'package:app1/internal/bloc/authorization/authorization_bloc.dart';
import 'package:app1/internal/bloc/collection_food/collection_food_bloc.dart';
import 'package:app1/internal/bloc/colletion/collection_bloc.dart';
import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/internal/bloc/registration/registration_bloc.dart';
import 'package:app1/internal/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/internal/cubit/get_page_cubit.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///TODO | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ | Сделать валидацию при регистрации |
///TODO Сделать везде проверку на инет и вылет окна ошибки(Делать с помощью структуры
///TODO try catch(throw))
///TODO При редакстировании еды, создаётся новая или нет(нужно потестить и разобраться)


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyFitnessApp());
}


class MyFitnessApp extends StatelessWidget {
  MyFitnessApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    addScreenSize(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserInfoBloc>(
              create: (BuildContext context) => UserInfoBloc()
          ),
          BlocProvider<AuthorizationBloc>(
              create: (BuildContext context) => AuthorizationBloc()
          ),
          BlocProvider<GetPageCubit>(
              create: (BuildContext context) => GetPageCubit()
          ),
          BlocProvider<UserImageBloc>(
              create: (BuildContext context) => UserImageBloc()
          ),
          BlocProvider<FoodBloc>(
              create: (BuildContext context) => FoodBloc()
          ),
          BlocProvider<EatingFoodBloc>(
              create: (BuildContext context) => EatingFoodBloc()
          ),
          BlocProvider<RegistrationBloc>(
              create: (BuildContext context) => RegistrationBloc()
          ),
          BlocProvider<CollectionBloc>(
              create: (BuildContext context) => CollectionBloc()
          ),
          BlocProvider<CollectionFoodBloc>(
              create: (BuildContext context) => CollectionFoodBloc()
          ),
        ],
        child: MaterialApp.router(
          theme: createTheme(),
          debugShowCheckedModeBanner: false,
          //home: const StartPage(),
          routerConfig: _appRouter.config(),
        )
    );
  }
}

