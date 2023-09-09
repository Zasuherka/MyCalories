import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/firstPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Future<FirebaseApp> isNullUser() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null)
    {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FirstPage()));
    }
    else
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const  AuthorizationPage()));
    }
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    isNullUser();
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            alignment: Alignment.center,
            child:
            SvgPicture.asset(
              'images/icon.svg',
              colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color), // Применение прозрачного фильтра
              height: screenHeight/3.36,
            )
        ),
      ),
    );
  }
}

