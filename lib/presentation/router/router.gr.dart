// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    CollectionsRoute.name: (routeData) {
      final args = routeData.argsAs<CollectionsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CollectionsPage(
          key: args.key,
          isAddEatingFood: args.isAddEatingFood,
        ),
      );
    },
    CreateCollectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateCollectionPage(),
      );
    },
    EditingProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditingProfilePage(),
      );
    },
    FirstRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FirstPage(),
      );
    },
    GoalRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GoalPage(),
      );
    },
    MenuRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MenuPage(),
      );
    },
    MyCaloriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyCaloriesPage(),
      );
    },
    MyFoodRoute.name: (routeData) {
      final args = routeData.argsAs<MyFoodRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyFoodPage(
          key: args.key,
          isAddEatingFood: args.isAddEatingFood,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    SaveCollectionRoute.name: (routeData) {
      final args = routeData.argsAs<SaveCollectionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SaveCollectionPage(
          key: args.key,
          listFood: args.listFood,
        ),
      );
    },
    StartRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StartPage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CollectionsPage]
class CollectionsRoute extends PageRouteInfo<CollectionsRouteArgs> {
  CollectionsRoute({
    Key? key,
    required bool isAddEatingFood,
    List<PageRouteInfo>? children,
  }) : super(
          CollectionsRoute.name,
          args: CollectionsRouteArgs(
            key: key,
            isAddEatingFood: isAddEatingFood,
          ),
          initialChildren: children,
        );

  static const String name = 'CollectionsRoute';

  static const PageInfo<CollectionsRouteArgs> page =
      PageInfo<CollectionsRouteArgs>(name);
}

class CollectionsRouteArgs {
  const CollectionsRouteArgs({
    this.key,
    required this.isAddEatingFood,
  });

  final Key? key;

  final bool isAddEatingFood;

  @override
  String toString() {
    return 'CollectionsRouteArgs{key: $key, isAddEatingFood: $isAddEatingFood}';
  }
}

/// generated route for
/// [CreateCollectionPage]
class CreateCollectionRoute extends PageRouteInfo<void> {
  const CreateCollectionRoute({List<PageRouteInfo>? children})
      : super(
          CreateCollectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateCollectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditingProfilePage]
class EditingProfileRoute extends PageRouteInfo<void> {
  const EditingProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditingProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditingProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FirstPage]
class FirstRoute extends PageRouteInfo<void> {
  const FirstRoute({List<PageRouteInfo>? children})
      : super(
          FirstRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GoalPage]
class GoalRoute extends PageRouteInfo<void> {
  const GoalRoute({List<PageRouteInfo>? children})
      : super(
          GoalRoute.name,
          initialChildren: children,
        );

  static const String name = 'GoalRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MenuPage]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute({List<PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyCaloriesPage]
class MyCaloriesRoute extends PageRouteInfo<void> {
  const MyCaloriesRoute({List<PageRouteInfo>? children})
      : super(
          MyCaloriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyCaloriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyFoodPage]
class MyFoodRoute extends PageRouteInfo<MyFoodRouteArgs> {
  MyFoodRoute({
    Key? key,
    required bool isAddEatingFood,
    List<PageRouteInfo>? children,
  }) : super(
          MyFoodRoute.name,
          args: MyFoodRouteArgs(
            key: key,
            isAddEatingFood: isAddEatingFood,
          ),
          initialChildren: children,
        );

  static const String name = 'MyFoodRoute';

  static const PageInfo<MyFoodRouteArgs> page = PageInfo<MyFoodRouteArgs>(name);
}

class MyFoodRouteArgs {
  const MyFoodRouteArgs({
    this.key,
    required this.isAddEatingFood,
  });

  final Key? key;

  final bool isAddEatingFood;

  @override
  String toString() {
    return 'MyFoodRouteArgs{key: $key, isAddEatingFood: $isAddEatingFood}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SaveCollectionPage]
class SaveCollectionRoute extends PageRouteInfo<SaveCollectionRouteArgs> {
  SaveCollectionRoute({
    Key? key,
    required List<Food> listFood,
    List<PageRouteInfo>? children,
  }) : super(
          SaveCollectionRoute.name,
          args: SaveCollectionRouteArgs(
            key: key,
            listFood: listFood,
          ),
          initialChildren: children,
        );

  static const String name = 'SaveCollectionRoute';

  static const PageInfo<SaveCollectionRouteArgs> page =
      PageInfo<SaveCollectionRouteArgs>(name);
}

class SaveCollectionRouteArgs {
  const SaveCollectionRouteArgs({
    this.key,
    required this.listFood,
  });

  final Key? key;

  final List<Food> listFood;

  @override
  String toString() {
    return 'SaveCollectionRouteArgs{key: $key, listFood: $listFood}';
  }
}

/// generated route for
/// [StartPage]
class StartRoute extends PageRouteInfo<void> {
  const StartRoute({List<PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
