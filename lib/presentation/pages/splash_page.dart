import 'package:app1/internal/cubit/warning_cubit/warning_cubit.dart';
import 'package:app1/internal/cubit/get_page_cubit/get_page_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/auth_page/auth_page.dart';
import 'package:app1/presentation/pages/main_page.dart';
import 'package:app1/presentation/widgets/connection_snack_bar_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
    return BlocListener<WarningCubit, WarningCubitState>(
      listener: (BuildContext context, WarningCubitState state) {
        if (state is Disconnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: WarningSnackBar(
                title: 'Подключение к интернету отсутствует',
                suffix: SvgPicture.asset(
                  'images/wi-fi_off.svg',
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(AppColors.turquoise, BlendMode.srcIn),
                ),
              ),
              duration: const Duration(days: 1),
            ),
          );
        } else if (state is Connected) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        } if (state is SaveInfo){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: WarningSnackBar(
                title: 'Информация сохранена',
              ),
              duration: Duration(days: 1),
            ),
          );
        } else if(state is ErrorSaveInfo){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: WarningSnackBar(
                title: 'Что-то пошло не так, попробуйте ещё раз',
                textColor: AppColors.red,
              ),
              duration: Duration(days: 1),
            ),
          );
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
                page = const MainPage();
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
                height: 250,
              ),
            ),
          );
        },
      ),
    );
  }
}
