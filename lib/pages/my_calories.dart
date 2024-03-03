import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/widgets/calories_chart.dart';
import 'package:app1/widgets/eating_widget.dart';
import 'package:app1/widgets/PFC_chart.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyCaloriesPage extends StatefulWidget {
  const MyCaloriesPage({super.key});

  @override
  State<MyCaloriesPage> createState() => _MyCaloriesPageState();
}

class _MyCaloriesPageState extends State<MyCaloriesPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body:
        SingleChildScrollView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 5,
              left: 12.5, right: 12.5
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: PFCChart(title: 'БЕЛКИ')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: PFCChart(title: 'ЖИРЫ')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: PFCChart(title: 'УГЛЕВОДЫ')),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CaloriesChart(),
                SizedBox(
                  height: 10,
                ),
                EatingWidget(title: 'Завтрак'),
                SizedBox(
                  height: 10,
                ),
                EatingWidget(title: 'Обед'),
                SizedBox(
                  height: 10,
                ),
                EatingWidget(title: 'Ужин'),
                SizedBox(
                  height: 10,
                ),
                EatingWidget(title: 'Другое'),
                SizedBox(
                  height: 10,
                ),
              ],
            )
        )
    );
  }
}
