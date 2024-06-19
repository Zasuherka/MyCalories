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
    CoachCollectionsRoute.name: (routeData) {
      final args = routeData.argsAs<CoachCollectionsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CoachCollectionsPage(
          key: args.key,
          isAddEatingFood: args.isAddEatingFood,
        ),
      );
    },
    CollectionRoute.name: (routeData) {
      final args = routeData.argsAs<CollectionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CollectionPage(
          key: args.key,
          collectionId: args.collectionId,
        ),
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
    CompletedWorkoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CompletedWorkoutPage(),
      );
    },
    CompletedWorkoutsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CompletedWorkoutsPage(),
      );
    },
    CreateCollectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateCollectionPage(),
      );
    },
    CurrentWorkoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CurrentWorkoutPage(),
      );
    },
    EditingProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditingProfilePage(),
      );
    },
    FoodDiaryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FoodDiaryPage(),
      );
    },
    GoalRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GoalPage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
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
    MyCoachRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyCoachPage(),
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
          collection: args.collection,
        ),
      );
    },
    ScheduledWorkoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ScheduledWorkoutPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    UpdateCollectionRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateCollectionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UpdateCollectionPage(
          key: args.key,
          collection: args.collection,
        ),
      );
    },
    WardCompletedWorkoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WardCompletedWorkoutPage(),
      );
    },
    WardCompletedWorkoutsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WardCompletedWorkoutsPage(),
      );
    },
    WardFoodDiaryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WardFoodDiaryPage(),
      );
    },
    WardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WardPage(),
      );
    },
    WardsListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WardsListPage(),
      );
    },
    WardsRequestsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WardsRequestsPage(),
      );
    },
    WorkoutForWardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WorkoutForWardPage(),
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
/// [CoachCollectionsPage]
class CoachCollectionsRoute extends PageRouteInfo<CoachCollectionsRouteArgs> {
  CoachCollectionsRoute({
    Key? key,
    required bool isAddEatingFood,
    List<PageRouteInfo>? children,
  }) : super(
          CoachCollectionsRoute.name,
          args: CoachCollectionsRouteArgs(
            key: key,
            isAddEatingFood: isAddEatingFood,
          ),
          initialChildren: children,
        );

  static const String name = 'CoachCollectionsRoute';

  static const PageInfo<CoachCollectionsRouteArgs> page =
      PageInfo<CoachCollectionsRouteArgs>(name);
}

class CoachCollectionsRouteArgs {
  const CoachCollectionsRouteArgs({
    this.key,
    required this.isAddEatingFood,
  });

  final Key? key;

  final bool isAddEatingFood;

  @override
  String toString() {
    return 'CoachCollectionsRouteArgs{key: $key, isAddEatingFood: $isAddEatingFood}';
  }
}

/// generated route for
/// [CollectionPage]
class CollectionRoute extends PageRouteInfo<CollectionRouteArgs> {
  CollectionRoute({
    Key? key,
    required String collectionId,
    List<PageRouteInfo>? children,
  }) : super(
          CollectionRoute.name,
          args: CollectionRouteArgs(
            key: key,
            collectionId: collectionId,
          ),
          initialChildren: children,
        );

  static const String name = 'CollectionRoute';

  static const PageInfo<CollectionRouteArgs> page =
      PageInfo<CollectionRouteArgs>(name);
}

class CollectionRouteArgs {
  const CollectionRouteArgs({
    this.key,
    required this.collectionId,
  });

  final Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'CollectionRouteArgs{key: $key, collectionId: $collectionId}';
  }
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
/// [CompletedWorkoutPage]
class CompletedWorkoutRoute extends PageRouteInfo<void> {
  const CompletedWorkoutRoute({List<PageRouteInfo>? children})
      : super(
          CompletedWorkoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletedWorkoutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CompletedWorkoutsPage]
class CompletedWorkoutsRoute extends PageRouteInfo<void> {
  const CompletedWorkoutsRoute({List<PageRouteInfo>? children})
      : super(
          CompletedWorkoutsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletedWorkoutsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [CurrentWorkoutPage]
class CurrentWorkoutRoute extends PageRouteInfo<void> {
  const CurrentWorkoutRoute({List<PageRouteInfo>? children})
      : super(
          CurrentWorkoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrentWorkoutRoute';

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
/// [FoodDiaryPage]
class FoodDiaryRoute extends PageRouteInfo<void> {
  const FoodDiaryRoute({List<PageRouteInfo>? children})
      : super(
          FoodDiaryRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodDiaryRoute';

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
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

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
/// [MyCoachPage]
class MyCoachRoute extends PageRouteInfo<void> {
  const MyCoachRoute({List<PageRouteInfo>? children})
      : super(
          MyCoachRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyCoachRoute';

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
    Collection? collection,
    List<PageRouteInfo>? children,
  }) : super(
          SaveCollectionRoute.name,
          args: SaveCollectionRouteArgs(
            key: key,
            listFood: listFood,
            collection: collection,
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
    this.collection,
  });

  final Key? key;

  final List<Food> listFood;

  final Collection? collection;

  @override
  String toString() {
    return 'SaveCollectionRouteArgs{key: $key, listFood: $listFood, collection: $collection}';
  }
}

/// generated route for
/// [ScheduledWorkoutPage]
class ScheduledWorkoutRoute extends PageRouteInfo<void> {
  const ScheduledWorkoutRoute({List<PageRouteInfo>? children})
      : super(
          ScheduledWorkoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScheduledWorkoutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpdateCollectionPage]
class UpdateCollectionRoute extends PageRouteInfo<UpdateCollectionRouteArgs> {
  UpdateCollectionRoute({
    Key? key,
    required Collection collection,
    List<PageRouteInfo>? children,
  }) : super(
          UpdateCollectionRoute.name,
          args: UpdateCollectionRouteArgs(
            key: key,
            collection: collection,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateCollectionRoute';

  static const PageInfo<UpdateCollectionRouteArgs> page =
      PageInfo<UpdateCollectionRouteArgs>(name);
}

class UpdateCollectionRouteArgs {
  const UpdateCollectionRouteArgs({
    this.key,
    required this.collection,
  });

  final Key? key;

  final Collection collection;

  @override
  String toString() {
    return 'UpdateCollectionRouteArgs{key: $key, collection: $collection}';
  }
}

/// generated route for
/// [WardCompletedWorkoutPage]
class WardCompletedWorkoutRoute extends PageRouteInfo<void> {
  const WardCompletedWorkoutRoute({List<PageRouteInfo>? children})
      : super(
          WardCompletedWorkoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'WardCompletedWorkoutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WardCompletedWorkoutsPage]
class WardCompletedWorkoutsRoute extends PageRouteInfo<void> {
  const WardCompletedWorkoutsRoute({List<PageRouteInfo>? children})
      : super(
          WardCompletedWorkoutsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WardCompletedWorkoutsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WardFoodDiaryPage]
class WardFoodDiaryRoute extends PageRouteInfo<void> {
  const WardFoodDiaryRoute({List<PageRouteInfo>? children})
      : super(
          WardFoodDiaryRoute.name,
          initialChildren: children,
        );

  static const String name = 'WardFoodDiaryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WardPage]
class WardRoute extends PageRouteInfo<void> {
  const WardRoute({List<PageRouteInfo>? children})
      : super(
          WardRoute.name,
          initialChildren: children,
        );

  static const String name = 'WardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WardsListPage]
class WardsListRoute extends PageRouteInfo<void> {
  const WardsListRoute({List<PageRouteInfo>? children})
      : super(
          WardsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'WardsListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WardsRequestsPage]
class WardsRequestsRoute extends PageRouteInfo<void> {
  const WardsRequestsRoute({List<PageRouteInfo>? children})
      : super(
          WardsRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WardsRequestsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkoutForWardPage]
class WorkoutForWardRoute extends PageRouteInfo<void> {
  const WorkoutForWardRoute({List<PageRouteInfo>? children})
      : super(
          WorkoutForWardRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutForWardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
