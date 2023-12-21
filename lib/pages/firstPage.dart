import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/bloc/userImage/user_image_bloc.dart';
import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/pages/menuPage.dart';
import 'package:app1/pages/myCalories.dart';
import 'package:app1/pages/myFoodPage.dart';
import 'package:app1/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///TODO убрать из комментов User user

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Widget> pages = [const Menu(), const MyCalories(), const Profile()];
  //List<Widget> pages = [const MyFoodPage(isAddEatingFood: false), const MyCalories(), const Profile()];
  int pageIndex = 1;
  int _selectedIndex = 1;
  Icon iconProfile = const Icon(Icons.person_outline);
  Icon iconFood = const Icon(Icons.food_bank_outlined);
  Icon iconHome = const Icon(Icons.home_outlined);

  Widget getPage(int index) {
    return pages[index];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      iconProfile = const Icon(Icons.person_outline);
      iconFood = const Icon(Icons.food_bank_outlined);
      iconHome = const Icon(Icons.home_outlined);
      switch (index) {
        case 0:
          pageIndex = 0;
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank);
          iconHome = const Icon(Icons.home_outlined);
        case 1:
          BlocProvider.of<EatingFoodBloc>(context).add((GetAllEatingFoodListEvent()));
          pageIndex = 1;
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home);
        case 2:
          BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
          BlocProvider.of<UserImageBloc>(context).add(LoadImageEvent());
          pageIndex = 2;
          iconProfile = const Icon(Icons.person);
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: iconFood, label: 'Меню'),
            BottomNavigationBarItem(icon: iconHome, label: 'Дневник'),
            BottomNavigationBarItem(icon: iconProfile, label: 'Профиль'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.green,
          onTap: _onItemTapped,
        ),
        body:
            getPage(pageIndex),
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
