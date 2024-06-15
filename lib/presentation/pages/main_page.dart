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

  void changeScreen(int index) async{
    activeChangedPageView = false;
    await _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400 * (_selectedIndex - index).abs()),
      curve: Curves.easeIn,
    );
    if(index != _selectedIndex) setState(() => _selectedIndex = index);
    activeChangedPageView = true;
  }

  void _indexSwitch(int index){
    switch (index) {
      case 0:
      case 1:
        BlocProvider.of<EatingFoodBloc>(context).add(const EatingFoodEvent.updateEatingState());
      case 2:
      //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
        BlocProvider.of<UserImageBloc>(context).add(const UserImageEvent.loadImage());
      case 3:
    }
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
                      BottomNavigationBarItem(
                        icon:
                        Icon(_selectedIndex == 0 ? Icons.food_bank : Icons.food_bank_outlined),
                        label: 'Питание',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(_selectedIndex == 1 ? Icons.home : Icons.home_outlined),
                        label: 'Дневник',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(_selectedIndex == 2 ? Icons.person : Icons.person_2_outlined),
                        label: 'Профиль',
                      ),
                      BottomNavigationBarItem(
                        icon: _selectedIndex == 3
                            ? SvgPicture.asset(
                          'images/workout.svg',
                          colorFilter: const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                          height: 20,
                        ) :
                        SvgPicture.asset(
                          'images/workout_outlined.svg',
                          colorFilter: const ColorFilter.mode(AppColors.inactiveIconColor, BlendMode.srcIn),
                          height: 20,
                        ),
                        label: 'Спорт',
                      ),
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
                    onTap: changeScreen,
                  ),
                ),
                body: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int index) {
                    if(activeChangedPageView) setState(() => _selectedIndex = index);
                    _indexSwitch(index);
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