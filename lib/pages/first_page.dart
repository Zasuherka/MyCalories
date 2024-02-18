import 'package:app1/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/bloc/user_image_bloc/user_image_bloc.dart';
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
          BlocProvider.of<FoodBloc>(context).add(const FoodEvent.getFoodList());
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank);
          iconHome = const Icon(Icons.home_outlined);
        case 1:
          BlocProvider.of<EatingFoodBloc>(context).add(const EatingFoodEvent.updateEatingState());
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home);
        case 2:
          //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
          BlocProvider.of<UserImageBloc>(context).add(const UserImageEvent.loadImage());
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
    BlocProvider.of<EatingFoodBloc>(context).add(const EatingFoodEvent.updateEatingState());
  }





  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('images/background_image.png',
          height: screenHeight,
          width: screenWidth,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: AppColors.elementColor,
              //gradient: AppColors.greenGradient
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: iconFood, label: 'Меню'),
                BottomNavigationBarItem(icon: iconHome, label: 'Дневник'),
                BottomNavigationBarItem(icon: iconProfile, label: 'Профиль'),
                BottomNavigationBarItem(icon: temporary, label: 'КБЖУ'),
              ],
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              showUnselectedLabels: false,
              elevation: 0,
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.white,
              unselectedItemColor: AppColors.white.withOpacity(0.7),
              onTap: _onItemTapped,
            ),
          ),
          body: getPage(_selectedIndex),
        )
      ],
    );
  }
}
