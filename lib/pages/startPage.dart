import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/firstPage.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Future<void> isNullUser() async
  {
    bool startPage = await getPage();
    if(startPage){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FirstPage()));
    }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthorizationPage()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNullUser();
  }
  @override
  Widget build(BuildContext context) {
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

