import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/registrationPage.dart';
import 'package:flutter/material.dart';
import 'package:app1/pages/firstPage.dart';
import 'package:firebase_core/firebase_core.dart';


void initFireBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() {
  initFireBase();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/authorizationPage',
    routes: {
      '/startPage': (context) => const FirstPage(),
      '/authorizationPage': (context) => const AuthorizationPage(),
      '/registrationPage': (context) => const RegistrationPage(),
    },
  ));
}

