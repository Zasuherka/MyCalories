import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/pages/auth_page/auth_page.dart';
import 'package:app1/presentation/pages/collections_pages/collections_page.dart';
import 'package:app1/presentation/pages/collections_pages/create_collection_page.dart';
import 'package:app1/presentation/pages/editing_profile_page.dart';
import 'package:app1/presentation/pages/first_page.dart';
import 'package:app1/presentation/pages/goal_page/goal_page.dart';
import 'package:app1/presentation/pages/menu_page.dart';
import 'package:app1/presentation/pages/my_calories/my_calories.dart';
import 'package:app1/presentation/pages/my_food_page/my_food_page.dart';
import 'package:app1/presentation/pages/collections_pages/save_collection_page.dart';
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
        page: CollectionsRoute.page,
        path: '/collectionsPage'
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
        page: CreateCollectionRoute.page,
        path: '/createCollectionPage'
    ),
    MaterialRoute(
        page: SaveCollectionRoute.page,
        path: '/saveCollectionPage'
    ),
    MaterialRoute(
        page: StartRoute.page,
        path: '/',
        initial: true
    ),
  ];
}