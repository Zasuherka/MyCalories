import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/menu_page.dart';
import 'package:app1/presentation/pages/my_calories/my_calories.dart';
import 'package:app1/presentation/pages/profile_page/profile_page.dart';
import 'package:app1/presentation/pages/workout_menu_page/workout_menu_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List<Widget> pages = [
    const MenuPage(),
    const MyCaloriesPage(),
    const ProfilePage(),
    const WorkoutMenuPage()
  ];
  int _selectedIndex = 1;
  Widget iconProfile = const Icon(Icons.person_outline);
  Widget iconFood = const Icon(Icons.food_bank_outlined);
  Widget iconHome = const Icon(Icons.home);
  Widget iconWorkoutMenu = SvgPicture.asset('images/workout_outlined.svg',
    colorFilter: const ColorFilter.mode(AppColors.inactiveIconColor, BlendMode.srcIn),
    height: 20,
  );

  Widget getPage(int index) {
    return pages[index];
  }

  void _onItemTapped(int index) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedIndex = index;
      iconHome = const Icon(Icons.home);
      switch (index) {
        case 0:
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank);
          iconHome = const Icon(Icons.home_outlined);
          iconWorkoutMenu = SvgPicture.asset('images/workout_outlined.svg',
            colorFilter: const ColorFilter.mode(AppColors.inactiveIconColor, BlendMode.srcIn),
            height: 20,
          );
        case 1:
          BlocProvider.of<EatingFoodBloc>(context).add(const EatingFoodEvent.updateEatingState());
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home);
          iconWorkoutMenu = SvgPicture.asset('images/workout_outlined.svg',
            colorFilter: const ColorFilter.mode(AppColors.inactiveIconColor, BlendMode.srcIn),
            height: 20,
          );
        case 2:
          //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
          BlocProvider.of<UserImageBloc>(context).add(const UserImageEvent.loadImage());
          iconProfile = const Icon(Icons.person);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home_outlined);
          iconWorkoutMenu = SvgPicture.asset('images/workout_outlined.svg',
            colorFilter: const ColorFilter.mode(AppColors.inactiveIconColor, BlendMode.srcIn),
            height: 20,
          );
        case 3:
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home_outlined);
          iconWorkoutMenu = SvgPicture.asset('images/workout.svg',
            colorFilter: const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
            height: 20,
          );
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.backGroundColor,
            bottomNavigationBar:
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.greenGradient
              ),
              height: 55,
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: iconFood, label: 'Меню'),
                  BottomNavigationBarItem(icon: iconHome, label: 'Дневник'),
                  BottomNavigationBarItem(icon: iconProfile, label: 'Профиль'),
                  BottomNavigationBarItem(icon: iconWorkoutMenu, label: 'Спорт'),
                  // BottomNavigationBarItem(icon: temporary, label: 'КБЖУ'),
                  // BottomNavigationBarItem(icon: icon, label: 'Мои коллекции'),
                ],
                iconSize: 20,
                selectedFontSize: 10,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                showUnselectedLabels: false,
                elevation: 0,
                currentIndex: _selectedIndex,
                selectedItemColor: AppColors.primaryButtonColor,
                unselectedItemColor: AppColors.inactiveIconColor,
                onTap: _onItemTapped,
              ),
            ),
            body: getPage(_selectedIndex),
          ),
        )
      ],
    );
  }
}
