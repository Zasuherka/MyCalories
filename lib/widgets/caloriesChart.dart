import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloriesChart extends StatefulWidget {
  const CaloriesChart({super.key});

  @override
  State<CaloriesChart> createState() => _CaloriesChartState();
}

class _CaloriesChartState extends State<CaloriesChart> {
  double value = 0;
  double goalValue = 2500;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<EatingFoodBloc, EatingFoodState>(builder: (context, state){
      if(state is GetEatingFoodListState || state is EatingFoodInitialState){
        value = state.eatingValues['КАЛОРИИ']!;

      }
      return Container(
        width: screenWidth * 0.95,
        height: screenHeight * 0.09,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 13,
                offset: const Offset(10, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(25.0)
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: screenWidth * 0.075)),
                Text(
                  'КАЛОРИИ: ${value.toInt()}/${goalValue.toInt()}',
                  style: TextStyle(
                    fontSize: screenHeight/50,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.03,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: LinearProgressIndicator(
                    value: value / goalValue, // Здесь вычисляем процент заполнения
                    backgroundColor: const Color.fromRGBO(255, 0, 13, 1.0), // Цвет фона
                    valueColor: const AlwaysStoppedAnimation<Color>(Color.fromRGBO(16, 240, 12, 1.0)),
                    // Цвет заполнения
                  ),
                )
            )
          ],
        ),
      );
    });
  }
}
