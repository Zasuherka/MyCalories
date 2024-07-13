import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/custom_buttons/primary_app_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show ImageFilter;

import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWorkoutEndDialog extends StatelessWidget {
  const CurrentWorkoutEndDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Dialog(
            backgroundColor: AppColors.primaryButtonColor,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Закончить тренировку?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Данная тренировка будет закончена и станет доступна для просмотра '
                        'в разделе с выполненными тренировками',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryAppButton(
                          onTap: (){
                            context.read<WorkoutCubit>().currentWorkoutEnd();
                            context.router.popForced();
                          },
                          borderRadius: 15,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Закончить',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: AppColors.primaryTextColor
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: PrimaryAppButton(
                          onTap: (){
                            context.router.popForced();
                          },
                          borderRadius: 15,
                          withColor: true,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Отмена',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: AppColors.secondaryTextColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
