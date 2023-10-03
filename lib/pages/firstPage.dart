import 'package:app1/objects/user.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/myFoodPage.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:app1/widgets/myCalories.dart';
import 'package:app1/widgets/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///TODO убрать из комментов User user

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}


class _FirstPageState extends State<FirstPage> {
  List<Widget> pages = [const Profile(),const MyCalories(),const Profile()];
  int pageIndex = 1;
  int _selectedIndex = 1;
  Icon iconProfile = const Icon(Icons.person_outline);
  Icon iconFood = const Icon(Icons.food_bank_outlined);
  Icon iconHome = const Icon(Icons.home_outlined);
  //String name = '';
  //AppUser? user;


  // Future<void> getUser() async
  // {
  //   user = await getAppUser();
  //   setState(() {
  //     name = user!.name!;
  //   });
  // }

  Widget getPage(int index)
  {
    return pages[index];
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      iconProfile = const Icon(Icons.person_outline);
      iconFood = const Icon(Icons.food_bank_outlined);
      iconHome = const Icon(Icons.home_outlined);
      switch (index)
      {
        case 0:
          pageIndex = 0;
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank);
          iconHome = const Icon(Icons.home_outlined);
        case 1:
          pageIndex = 1;
          iconProfile = const Icon(Icons.person_outline);
          iconFood = const Icon(Icons.food_bank_outlined);
          iconHome = const Icon(Icons.home);
        case 2:
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
    SystemChrome.setPreferredOrientations([ //Для заблокирования ориентации экрана(чтобы работало только в вертикальном режиме)
      DeviceOrientation.portraitUp,
    ]);
    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: iconFood,
              label: 'My Food'
          ),
          BottomNavigationBarItem(
              icon: iconHome,
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: iconProfile,
              label: 'Profile'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(16, 240, 12, 1.0),
        onTap: _onItemTapped,
      ),
      body:
      //getPage(pageIndex),
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyFoodPage()));
            },
            child: Text(localUser!.name.toString()),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
            onPressed: () async {
              await exitUser();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthorizationPage()));
            },
            child: const Text('Выход'),
          )
        ],
      )
      )
    );
  }}
