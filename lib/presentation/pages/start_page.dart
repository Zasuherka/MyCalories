import 'package:app1/internal/cubit/get_page_cubit.dart';
import 'package:app1/presentation/pages/auth_page/auth_page.dart';
import 'package:app1/presentation/pages/first_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
    SystemChrome.setPreferredOrientations([
      //Для заблокирования ориентации экрана(чтобы работало только в вертикальном режиме)
      DeviceOrientation.portraitUp,
    ]);
    BlocProvider.of<GetPageCubit>(context).listenLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPageCubit, GetPageState>(
      builder: (context, state) {
        Widget? page;
        state.whenOrNull(
          authPage: () {
            page = const AuthPage();
          },
            firstPage: () {
              page = const FirstPage();
          }
        );
        return page != null
            ? page!
            :
        Scaffold(
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
                  height: 250,
                )),
          ),
        );
      },
    );
  }
}
