import 'package:app1/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/pages/goal_page.dart';
import 'package:app1/pages/my_calories.dart';
import 'package:app1/pages/my_food_page.dart';
import 'package:app1/pages/profile_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///TODO убрать из комментов User user

@RoutePage()
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  //List<Widget> pages = [const Menu(), const MyCalories(), const Profile()];
  List<Widget> pages = [
    const MyFoodPage(isAddEatingFood: false),
    const MyCaloriesPage(),
    const ProfilePage(),
    const GoalPage()
  ];
  int _selectedIndex = 1;
  Icon iconProfile = const Icon(Icons.person_outline);
  Icon iconFood = const Icon(Icons.food_bank_outlined);
  Icon iconHome = const Icon(Icons.home_outlined);

  Icon temporary = const Icon(Icons.bar_chart);

  Widget getPage(int index) {
    return pages[index];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      iconProfile = const Icon(Icons.person_outline);
      iconFood = const Icon(Icons.food_bank_outlined);
      iconHome = const Icon(Icons.home_outlined);
      temporary = const Icon(Icons.bar_chart);
      switch (index) {
        case 0:
          BlocProvider.of<FoodBloc>(context).add(FoodInitialEvent());
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank);
          iconHome = const Icon(Icons.home_outlined);
        case 1:
          //BlocProvider.of<EatingFoodBloc>(context).add((GetAllEatingFoodListEvent()));
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home);
        case 2:
          //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
          BlocProvider.of<UserImageBloc>(context).add(LoadImageEvent());
          iconProfile = const Icon(Icons.person);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home_outlined);
        case 3:
          //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home_outlined);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      //Для заблокирования ориентации экрана(чтобы работало только в вертикальном режиме)
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(gradient: AppColors.greenGradient),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: iconFood, label: 'Меню'),
            BottomNavigationBarItem(icon: iconHome, label: 'Дневник'),
            BottomNavigationBarItem(icon: iconProfile, label: 'Профиль'),
            BottomNavigationBarItem(icon: temporary, label: 'КБЖУ'),
          ],
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white.withOpacity(0.7),
          onTap: _onItemTapped,
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: iconFood, label: 'Меню'),
      //     BottomNavigationBarItem(icon: iconHome, label: 'Дневник'),
      //     BottomNavigationBarItem(icon: iconProfile, label: 'Профиль'),
      //     BottomNavigationBarItem(icon: temporary, label: 'КБЖУ'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: AppColors.turquoise ,
      //   unselectedItemColor: AppColors.dark,
      //   onTap: _onItemTapped,
      // ),
      body: getPage(_selectedIndex),
      // Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         ElevatedButton(
      //         onPressed: () {
      //           BlocProvider.of<FoodBloc>(context).add(FoodInitialEvent());
      //           Navigator.of(context).push(context,MaterialPageRoute(builder: (context) =>const MyFoodPage(isUpdatePage: true)));
      //           },
      //           child: Text(localUser!.name.toString())),
      //         const Padding(padding: EdgeInsets.only(top: 20)),
      //         ElevatedButton(
      //           onPressed: () async {
      //             await exitUser();
      //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthorizationPage()));
      //             },
      //           child: const Text('Выход'),
      //         )
      //       ],
      //     )
      // )
    );
  }
}
