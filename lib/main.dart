import 'package:app1/di_container.dart';
import 'package:app1/internal/bloc/authorization_bloc/authorization_bloc.dart';
import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/internal/bloc/colletion_bloc/collection_bloc.dart';
import 'package:app1/internal/application_bloc_observer.dart';
import 'package:app1/internal/bloc/collection_food/collection_food_bloc.dart';
import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/internal/bloc/registration/registration_bloc.dart';
import 'package:app1/internal/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/internal/cubit/warning_cubit/warning_cubit.dart';
import 'package:app1/internal/cubit/food_diary_cubit/food_diary_cubit.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/internal/cubit/get_page_cubit/get_page_cubit.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await Firebase.initializeApp();
  Bloc.observer = ApplicationBlocObserver();
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
          BlocProvider<WarningCubit>(
              create: (BuildContext context) => getIt<WarningCubit>()
          ),
          BlocProvider<UserInfoBloc>(
              create: (BuildContext context) => getIt<UserInfoBloc>()
          ),
          BlocProvider<AuthorizationBloc>(
              create: (BuildContext context) => getIt<AuthorizationBloc>()
          ),
          BlocProvider<GetPageCubit>(
              create: (BuildContext context) => getIt<GetPageCubit>()
          ),
          BlocProvider<UserImageBloc>(
              create: (BuildContext context) => getIt<UserImageBloc>()
          ),
          BlocProvider<FoodBloc>(
              create: (BuildContext context) => getIt<FoodBloc>()
          ),
          BlocProvider<EatingFoodBloc>(
              create: (BuildContext context) => getIt<EatingFoodBloc>()
          ),
          BlocProvider<RegistrationBloc>(
              create: (BuildContext context) => getIt<RegistrationBloc>()
          ),
          BlocProvider<CollectionBloc>(
              create: (BuildContext context) => getIt<CollectionBloc>()
          ),
          BlocProvider<CollectionFoodBloc>(
              create: (BuildContext context) => getIt<CollectionFoodBloc>()
          ),
          BlocProvider<CoachBloc>(
              create: (BuildContext context) => getIt<CoachBloc>()
          ),
          BlocProvider<WardsBloc>(
              create: (BuildContext context) => getIt<WardsBloc>()
          ),
          BlocProvider<WorkoutCubit>(
              create: (BuildContext context) => getIt<WorkoutCubit>()
          ),
          BlocProvider<FoodDiaryCubit>(
              create: (BuildContext context) => getIt<FoodDiaryCubit>()
          ),
        ],
        child: MaterialApp.router(
          theme: createTheme(),
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          locale: const Locale('ru', 'RU'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        )
    );
  }
}

