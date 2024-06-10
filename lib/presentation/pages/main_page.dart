import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/menu_page.dart';
import 'package:app1/presentation/pages/my_calories/my_calories.dart';
import 'package:app1/presentation/pages/profile_page/profile_page.dart';
import 'package:app1/presentation/pages/workout_menu_page/workout_menu_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(initialPage: 1);

  int _selectedIndex = 1;

  bool activeChangedPageView = true;

  final List<Widget> pages = [
    const MenuPage(),
    const MyCaloriesPage(),
    const ProfilePage(),
    const WorkoutMenuPage()
  ];

  Widget iconProfile = const Icon(Icons.person_outline);
  Widget iconFood = const Icon(Icons.food_bank_outlined);
  Widget iconHome = const Icon(Icons.home);
  Widget iconWorkoutMenu = SvgPicture.asset('images/workout_outlined.svg',
    colorFilter: const ColorFilter.mode(AppColors.inactiveIconColor, BlendMode.srcIn),
    height: 20,
  );

  void changeScreen(int index) async{
    activeChangedPageView = false;
    await _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400 * (_selectedIndex - index).abs()),
      curve: Curves.easeIn,
    );
    setState(() => _selectedIndex = index);
    activeChangedPageView = true;
  }

  void _onItemTapped(int index) {
    FocusScope.of(context).unfocus();
    setState(() {
      iconHome = const Icon(Icons.home);
      changeScreen(index);
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
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        changeScreen(1);
      },
      child: Stack(
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
              body: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int index) {
                  if(activeChangedPageView) setState(() => _selectedIndex = index);
                },
                children: pages,
              )

              //getPage(_selectedIndex),
            ),
          )
        ],
      ),
    );
  }
}
