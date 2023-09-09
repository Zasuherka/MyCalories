import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/registrationPage.dart';
import 'package:app1/pages/startPage.dart';
import 'package:flutter/material.dart';
import 'package:app1/pages/firstPage.dart';

///TODO: ИСПРАВИТЬ ВЁРСТКУ | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => StartPage(),
      '/startPage': (context) => const FirstPage(),
      '/authorizationPage': (context) => const AuthorizationPage(),
      '/registrationPage': (context) => const RegistrationPage(),
    },
  ));
}

