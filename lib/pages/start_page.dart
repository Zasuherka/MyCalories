import 'package:app1/cubit/get_page_cubit.dart';
import 'package:app1/pages/auth_page.dart';
import 'package:app1/pages/first_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

@RoutePage()
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetPageCubit>(context).listenLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPageCubit, GetPageState>(
      builder: (context, state) {
        if(state is AuthPageState){
          return const AuthPage();
        }
        if(state is FirstPageState){
          return const FirstPage();
        }
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
    );
  }
}