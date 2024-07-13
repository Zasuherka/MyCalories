import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ScheduledWorkoutPage extends StatelessWidget {
  const ScheduledWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CoachBloc coachBloc = context.read<CoachBloc>();
    coachBloc.add(const CoachEvent.getScheduledWorkout());
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Запланированная',
          withoutRightIcon: true,
        ),
        body: BlocConsumer<CoachBloc, CoachState>(
          listener: (context, state) {
            state.whenOrNull(
              startScheduledWorkout: () => context.router.replace(const CurrentWorkoutRoute()),
            );
          },
          builder: (context, state) {

            if(coachBloc.scheduledWorkout == null){
              return Center(
                child: Text(
                  'Нет запланированных тренировок\n\nНа данном экране будут отображаться программы тренировок, '
                      'отправленные тренером',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.grey
                  ),
                ),
              );
            }

            return state.maybeMap(
              loading: (_) => Center(
                child: Image.asset(
                  'images/bouncing-circles.gif',
                  height: 100,
                ),
              ),
              orElse: () => ListView.builder(
                padding: const EdgeInsets.fromLTRB(7, 10, 7, 20),
                ///TODO с расширением функцонала и добавлением несколькоих запланированных, это надо переделать
                itemCount: coachBloc.scheduledWorkout == null ? 0 : 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => coachBloc.add(const CoachEvent.startScheduledWorkoutEvent()),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: AppColors.primaryButtonColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: boxShadow),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          coachBloc.scheduledWorkout?.title ?? '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
