import 'package:app1/data/database/database.dart';
import 'package:app1/data/repository/coach_repository.dart';
import 'package:app1/data/repository/collection_repository.dart';
import 'package:app1/data/repository/food_repository.dart';
import 'package:app1/data/repository/image_repository.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/data/repository/wards_repository.dart';
import 'package:app1/data/repository/workout_repository.dart';
import 'package:app1/internal/bloc/authorization_bloc/authorization_bloc.dart';
import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/internal/bloc/collection_food/collection_food_bloc.dart';
import 'package:app1/internal/bloc/colletion_bloc/collection_bloc.dart';
import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/internal/bloc/registration/registration_bloc.dart';
import 'package:app1/internal/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/internal/cubit/food_diary_cubit/food_diary_cubit.dart';
import 'package:app1/internal/cubit/get_page_cubit/get_page_cubit.dart';
import 'package:app1/internal/cubit/warning_cubit/warning_cubit.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';



/*
  registerFactory - каждый раз будет возвращать новый экземпляр класса
  registerSingleton - каждый раз будет возвращать один и тот же экземпляр класса
  registerLazySingleton - тоже самое что и [registerSingleton],
  только создание первого объекта будет происходить только тогда когда он потребуется
*/

late final GetIt getIt;

Future<void> setupGetIt() async {
  getIt = GetIt.instance;

  _registerDatabase();
  _registerRepositories();
  _registerBloc();
}

void _registerDatabase() {
  getIt.registerSingleton<Database>(Database());
}

void _registerRepositories() {
  getIt.registerSingleton<UserRepository>(
    UserRepository(
      database: getIt<Database>(),
    ),
  );

  getIt.registerSingleton<CoachRepository>(
    CoachRepository(
      userRepository: getIt<UserRepository>(),
      database: getIt<Database>(),
    ),
  );

  getIt.registerSingleton<WardRepository>(
    WardRepository(
      userRepository: getIt<UserRepository>(),
      database: getIt<Database>(),
    ),
  );

  getIt.registerSingleton<CollectionRepository>(
    CollectionRepository(
      userRepository: getIt<UserRepository>(),
      database: getIt<Database>(),
    ),
  );

  getIt.registerSingleton<FoodRepository>(
    FoodRepository(
      userRepository: getIt<UserRepository>(),
      database: getIt<Database>(),
    ),
  );

  getIt.registerSingleton<ImageRepository>(
    ImageRepository(
      userRepository: getIt<UserRepository>(),
      database: getIt<Database>(),
    ),
  );

  getIt.registerSingleton<WorkoutRepository>(
    WorkoutRepository(
      userRepository: getIt<UserRepository>(),
      database: getIt<Database>(),
    ),
  );
}

void _registerBloc() {

  getIt.registerFactory<WarningCubit>(
    () => WarningCubit(
      connectivity: Connectivity(),
    ),
  );

  getIt.registerFactory<CoachBloc>(
    () => CoachBloc(
      userRepository: getIt<UserRepository>(),
      coachRepository: getIt<CoachRepository>(),
    ),
  );

  getIt.registerFactory<WardsBloc>(
    () => WardsBloc(
      userRepository: getIt<UserRepository>(),
      wardRepository: getIt<WardRepository>(),
      foodRepository: getIt<FoodRepository>(),
    ),
  );

  getIt.registerFactory<AuthorizationBloc>(
        () => AuthorizationBloc(
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerFactory<CollectionFoodBloc>(
    () => CollectionFoodBloc(
      collectionRepository: getIt<CollectionRepository>(),
    ),
  );

  getIt.registerFactory<CollectionBloc>(
        () => CollectionBloc(
      collectionRepository: getIt<CollectionRepository>(),
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerFactory<GetPageCubit>(
    () => GetPageCubit(
      userRepository: getIt<UserRepository>(),
      foodRepository: getIt<FoodRepository>(),
      collectionRepository: getIt<CollectionRepository>(),
    ),
  );

  getIt.registerFactory<FoodBloc>(
        () => FoodBloc(
      userRepository: getIt<UserRepository>(),
      foodRepository: getIt<FoodRepository>(),
    ),
  );

  getIt.registerFactory<EatingFoodBloc>(
        () => EatingFoodBloc(
      userRepository: getIt<UserRepository>(),
      foodRepository: getIt<FoodRepository>(),
    ),
  );

  getIt.registerFactory<FoodDiaryCubit>(
        () => FoodDiaryCubit(
      foodRepository: getIt<FoodRepository>(),
    ),
  );

  getIt.registerFactory<UserInfoBloc>(
    () => UserInfoBloc(
      userRepository: getIt<UserRepository>(),
      imageRepository: getIt<ImageRepository>(),
    ),
  );

  getIt.registerFactory<UserImageBloc>(
    () => UserImageBloc(
      userRepository: getIt<UserRepository>(),
      imageRepository: getIt<ImageRepository>(),
    ),
  );

  getIt.registerFactory<RegistrationBloc>(
    () => RegistrationBloc(
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerFactory<WorkoutCubit>(
    () => WorkoutCubit(
      workoutRepository: getIt<WorkoutRepository>(),
    ),
  );
}