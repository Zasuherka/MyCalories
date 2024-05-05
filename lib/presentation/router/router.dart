import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/pages/auth_page/auth_page.dart';
import 'package:app1/presentation/pages/current_workout_page/current_workout_page.dart';
import 'package:app1/presentation/pages/update_collection_page/update_collection_update_page.dart';
import 'package:app1/presentation/pages/collections_pages/collections_page.dart';
import 'package:app1/presentation/pages/collections_pages/create_collection_page.dart';
import 'package:app1/presentation/pages/collection_page/collection_page.dart';
import 'package:app1/presentation/pages/editing_profile_page.dart';
import 'package:app1/presentation/pages/first_page.dart';
import 'package:app1/presentation/pages/goal_page/goal_page.dart';
import 'package:app1/presentation/pages/menu_page.dart';
import 'package:app1/presentation/pages/my_calories/my_calories.dart';
import 'package:app1/presentation/pages/my_food_page/my_food_page.dart';
import 'package:app1/presentation/pages/save_collection_page/save_collection_page.dart';
import 'package:app1/presentation/pages/start_page.dart';
import 'package:app1/presentation/pages/profile_page/profile_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{

  @override
  List<AutoRoute> get routes => [
    MaterialRoute(
        page: AuthRoute.page,
        path: '/authPage'
    ),

    MaterialRoute(
        page: EditingProfileRoute.page,
        path: '/editingFoodPage'
    ),
    MaterialRoute(
        page: FirstRoute.page,
        path: '/firstPage'
    ),
    MaterialRoute(
        page: GoalRoute.page,
        path: '/goalPage'
    ),
    MaterialRoute(
        page: MyCaloriesRoute.page,
        path: '/myCaloriesPage'
    ),
    MaterialRoute(
        page: MyFoodRoute.page,
        path: '/myFoodPagePage'
    ),
    MaterialRoute(
        page: ProfileRoute.page,
        path: '/profilePage'
    ),
    MaterialRoute(
        page: MenuRoute.page,
        path: '/menuPage'
    ),
    MaterialRoute(
        page: CreateCollectionRoute.page,
        path: '/createCollectionPage'
    ),
    MaterialRoute(
        page: CollectionsRoute.page,
        path: '/collectionsPage'
    ),
    MaterialRoute(
        page: CollectionRoute.page,
        path: '/collectionPage'
    ),
    MaterialRoute(
        page: SaveCollectionRoute.page,
        path: '/saveCollectionPage'
    ),
    MaterialRoute(
        page: UpdateCollectionRoute.page,
        path: '/updateCollectionPage'
    ),
    MaterialRoute(
        page: CurrentWorkoutRoute.page,
        path: '/currentWorkoutPage'
    ),
    MaterialRoute(
        page: StartRoute.page,
        path: '/',
        initial: true
    ),
  ];
}