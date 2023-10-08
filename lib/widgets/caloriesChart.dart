import 'package:flutter/material.dart';

class CaloriesChart extends StatefulWidget {
  final String goalValue;
  final String value;
  const CaloriesChart({super.key, required this.value, required this.goalValue});

  @override
  State<CaloriesChart> createState() => _CaloriesChartState();
}

class _CaloriesChartState extends State<CaloriesChart> {
  late double value;
  late double goalValue;
  @override
  void initState() {
    super.initState();
    value = double.parse(widget.value);
    goalValue = double.parse(widget.goalValue);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                value: value / 100, // Здесь вычисляем процент заполнения
                backgroundColor: const Color.fromRGBO(255, 0, 13, 1.0), // Цвет фона
                valueColor: const AlwaysStoppedAnimation<Color>(Color.fromRGBO(16, 240, 12, 1.0)),
                // Цвет заполнения
              ),
            )
          )
        ],
      )
      ,
    );
  }
}
