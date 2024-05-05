import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/training_set_exercise_with_active_title.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CurrentWorkoutPage extends StatelessWidget {
  const CurrentWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).padding.top + 20,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: AppColors.greenGradient
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 23),
          child: GestureDetector(
            onTap: () {
              context.router.popForced();
            },
            child: SvgPicture.asset(
              'images/arrow.svg',
              width: 33,
              height: 33,
              colorFilter:
              const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
            ),
          ),
        ),
        title: const Text(
            'Тренировки'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 7,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            WorkoutSetWithActiveTitle(
              onChanged: (title, sets, repetitions){
              },
            )
          ],
        ),
      ),
    );
  }
}
