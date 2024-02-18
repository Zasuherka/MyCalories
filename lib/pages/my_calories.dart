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
            child:Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + screenHeight/200),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                            child: const PFCChart(title: 'БЕЛКИ')
                        ),
                        Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                            child: const PFCChart(title: 'ЖИРЫ')
                        ),
                        Padding(padding: EdgeInsets.only(left: screenWidth * 0.025),
                            child: const PFCChart(title: 'УГЛЕВОДЫ')
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: screenHeight/75)),
                    const CaloriesChart(),
                    Padding(padding: EdgeInsets.only(top: screenHeight/75)),
                    const EatingWidget(title: 'Завтрак'),
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                    const EatingWidget(title: 'Обед'),
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                    const EatingWidget(title: 'Ужин'),
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                    const EatingWidget(title: 'Другое'),
                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                  ],
                )
            )
        )
    );
  }
}
