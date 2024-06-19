import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/pages/auth_page/auth_page.dart';
import 'package:app1/presentation/pages/coach_collections_page/coach_collections_page.dart';
import 'package:app1/presentation/pages/completed_workouts/completed_workout_page.dart';
import 'package:app1/presentation/pages/completed_workouts_page/completed_workouts_page.dart';
import 'package:app1/presentation/pages/current_workout_page/current_workout_page.dart';
import 'package:app1/presentation/pages/food_diary_page/food_diary_page.dart';
import 'package:app1/presentation/pages/my_coach_page/my_coach_page.dart';
import 'package:app1/presentation/pages/scheduled_workout_page/scheduled_workout_page.dart';
import 'package:app1/presentation/pages/update_collection_page/update_collection_update_page.dart';
import 'package:app1/presentation/pages/collections_pages/collections_page.dart';
import 'package:app1/presentation/pages/collections_pages/create_collection_page.dart';
import 'package:app1/presentation/pages/collection_page/collection_page.dart';
import 'package:app1/presentation/pages/editing_profile_page.dart';
import 'package:app1/presentation/pages/main_page.dart';
import 'package:app1/presentation/pages/goal_page/goal_page.dart';
import 'package:app1/presentation/pages/menu_page.dart';
import 'package:app1/presentation/pages/my_calories/my_calories.dart';
import 'package:app1/presentation/pages/my_food_page/my_food_page.dart';
import 'package:app1/presentation/pages/save_collection_page/save_collection_page.dart';
import 'package:app1/presentation/pages/splash_page.dart';
import 'package:app1/presentation/pages/profile_page/profile_page.dart';
import 'package:app1/presentation/pages/ward_page/food_diary_page.dart';
import 'package:app1/presentation/pages/ward_page/ward_completed_wordkouts_page.dart';
import 'package:app1/presentation/pages/ward_page/ward_completed_workout_page.dart';
import 'package:app1/presentation/pages/ward_page/ward_page.dart';
import 'package:app1/presentation/pages/ward_page/workout_for_ward_page.dart';
import 'package:app1/presentation/pages/ward_requests_page/ward_requests_page.dart';
import 'package:app1/presentation/pages/wards_list_page/wards_list_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{

  @override
  List<AutoRoute> get routes => [
    MaterialRoute(
        page: AuthRoute.page,
        path: '/auth_page'
    ),
    MaterialRoute(
        page: EditingProfileRoute.page,
        path: '/editing_food_page'
    ),
    MaterialRoute(
        page: MainRoute.page,
        path: '/first_page'
    ),
    MaterialRoute(
        page: GoalRoute.page,
        path: '/goal_page'
    ),
    MaterialRoute(
        page: MyCaloriesRoute.page,
        path: '/my_calories_page'
    ),
    MaterialRoute(
        page: MyFoodRoute.page,
        path: '/my_food_page'
    ),
    MaterialRoute(
        page: ProfileRoute.page,
        path: '/profile_page'
    ),
    MaterialRoute(
        page: MenuRoute.page,
        path: '/menu_page'
    ),
    MaterialRoute(
        page: CreateCollectionRoute.page,
        path: '/create_collection_page'
    ),
    MaterialRoute(
        page: CollectionsRoute.page,
        path: '/collections_page'
    ),
    MaterialRoute(
        page: CollectionRoute.page,
        path: '/collection_page'
    ),
    MaterialRoute(
        page: SaveCollectionRoute.page,
        path: '/save_collection_page'
    ),
    MaterialRoute(
        page: UpdateCollectionRoute.page,
        path: '/update_collection_page'
    ),
    MaterialRoute(
        page: CurrentWorkoutRoute.page,
        path: '/current_workout_page'
    ),
    MaterialRoute(
        page: CompletedWorkoutsRoute.page,
        path: '/completed_workouts_page',
        initial: false
    ),
    MaterialRoute(
        page: CompletedWorkoutRoute.page,
        path: '/completed_workout_page',
        initial: false
    ),
    MaterialRoute(
        page: FoodDiaryRoute.page,
        path: '/food_diary_page',
        initial: false
    ),
    MaterialRoute(
        page: MyCoachRoute.page,
        path: '/my_coach_page',
        initial: false
    ),
    MaterialRoute(
        page: CoachCollectionsRoute.page,
        path: '/coach_collection_page',
        initial: false
    ),
    MaterialRoute(
        page: WardsRequestsRoute.page,
        path: '/ward_requests_page',
        initial: false
    ),
    MaterialRoute(
        page: WardsListRoute.page,
        path: '/wards_list_page',
        initial: false
    ),
    MaterialRoute(
        page: WardRoute.page,
        path: '/ward_page',
        initial: false
    ),
    MaterialRoute(
        page: WardFoodDiaryRoute.page,
        path: '/ward_food_diary_page',
        initial: false
    ),
    MaterialRoute(
        page: WorkoutForWardRoute.page,
        path: '/workout_for_ward_page',
        initial: false
    ),
    MaterialRoute(
        page: ScheduledWorkoutRoute.page,
        path: '/scheduled_workout_page',
        initial: false
    ),
    MaterialRoute(
        page: WardCompletedWorkoutRoute.page,
        path: '/scheduled_workout_page',
        initial: false
    ),
    MaterialRoute(
        page: WardCompletedWorkoutsRoute.page,
        path: '/scheduled_workouts_page',
        initial: false
    ),
    MaterialRoute(
        page: SplashRoute.page,
        path: '/',
        initial: true
    ),
  ];
}