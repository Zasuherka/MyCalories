import 'package:app1/pages/auth_page.dart';
import 'package:app1/pages/collections_page.dart';
import 'package:app1/pages/editing_profile_page.dart';
import 'package:app1/pages/first_page.dart';
import 'package:app1/pages/goal_page.dart';
import 'package:app1/pages/menu_page.dart';
import 'package:app1/pages/my_calories.dart';
import 'package:app1/pages/my_food_page.dart';
import 'package:app1/pages/start_page.dart';
import 'package:app1/pages/profile_page.dart';
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
        page: StartRoute.page,
        path: '/',
        initial: true
    ),
  ];
}