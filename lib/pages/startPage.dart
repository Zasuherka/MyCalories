import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/bloc/getPage/get_page_bloc.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/firstPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final GetPageBloc getPageBloc = GetPageBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPageBloc.add(GetPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return BlocProvider<GetPageBloc>(
      create: (context) => getPageBloc,
      child: BlocListener<GetPageBloc, PageState>(
        bloc: getPageBloc,
        listener: (context, state) {
          if (state is GetPageAuthState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(
                    builder: (context) => const AuthorizationPage()));
          }
          if (state is GetPageAnotherState){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const FirstPage()));
          }
        },
        child: BlocBuilder<GetPageBloc, PageState>(
          bloc: getPageBloc,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'images/icon.svg',
                      colorFilter:
                      const ColorFilter.mode(
                          Colors.transparent, BlendMode.color),
                      // Применение прозрачного фильтра
                      height: screenHeight / 3.36,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
