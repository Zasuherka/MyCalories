import 'package:app1/internal/cubit/connection/connection_cubit.dart';
import 'package:app1/internal/cubit/get_page_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/auth_page/auth_page.dart';
import 'package:app1/presentation/pages/first_page.dart';
import 'package:app1/presentation/widgets/connection_snack_bar_content.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    return BlocListener<ConnectionCubit, ConnectionCubitState>(
      listener: (BuildContext context, ConnectionCubitState state) {
        if (state is Disconnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: ConnectionSnackBar(),
              duration: Duration(days: 1),
            ),
          );
        } else if (state is Connected) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: BlocBuilder<GetPageCubit, GetPageState>(
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
              child: SvgPicture.asset(
                'images/icon.svg',
                colorFilter:
                const ColorFilter.mode(
                    Colors.transparent, BlendMode.color),
                // Применение прозрачного фильтра
                height: 250,
              ),
            ),
          );
        },
      ),
    );
  }
}
