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
    Widget startPage = await getPage();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => startPage));
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

