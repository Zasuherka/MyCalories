import 'package:app1/presentation/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EatingCharts extends StatelessWidget {
  final double calories;
  final double protein;
  final double fats;
  final double carbohydrates;

  const EatingCharts({
    super.key,
    required this.calories,
    required this.protein,
    required this.fats,
    required this.carbohydrates,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: AppColors.primaryButtonColor,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100,
                width: 100,
                child: PieChart(
                  PieChartData(
                      sectionsSpace: 5,
                      startDegreeOffset: 270,
                      centerSpaceRadius: 28,
                      centerSpaceColor: Colors.white,
                      borderData: FlBorderData(show: false),
                      sections: [
                        PieChartSectionData(
                            title: '',
                            radius: 12,
                            value: carbohydrates,
                            color: AppColors.colorForCarbohydrates),
                        PieChartSectionData(
                            title: '',
                            radius: 12,
                            value: fats,
                            color: AppColors.colorForFats),
                        PieChartSectionData(
                            title: '',
                            radius: 12,
                            value: protein,
                            color: AppColors.colorForProtein),
                      ]),
                    swapAnimationDuration: animationDurationLong
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.red
                          ),
                        child: SizedBox(
                          height: 7,
                          width: 7,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text('Калории: ${calories.round()}'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.colorForProtein
                        ),
                        child: SizedBox(
                          height: 7,
                          width: 7,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text('Белки: ${protein.round()}'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.colorForFats
                        ),
                        child: SizedBox(
                          height: 7,
                          width: 7,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text('Жиры: ${fats.round()}'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.colorForCarbohydrates
                        ),
                        child: SizedBox(
                          height: 7,
                          width: 7,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text('Углеводы: ${carbohydrates.round()}'),
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
