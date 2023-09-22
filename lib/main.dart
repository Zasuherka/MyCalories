import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/myFoodPage.dart';
import 'package:app1/pages/registrationPage.dart';
import 'package:app1/pages/startPage.dart';
import 'package:flutter/material.dart';
import 'package:app1/pages/firstPage.dart';

///TODO | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ | Сделать валидацию при регистрации |

// Future<void> initialization() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseDatabase.instance;
// }

void main() {
  //initialization();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/startPage',
    routes: {
      '/myFoodPage': (context) => const MyFoodPage(),
      '/startPage': (context) => const StartPage(), ///TODO это начальный загрузочный экран, поэтому его в конце поставить как initialRoute
      '/firstPage': (context) => const FirstPage(),
      '/authorizationPage': (context) => const AuthorizationPage(),
      '/registrationPage': (context) => const RegistrationPage(),
    },
  ));
}

