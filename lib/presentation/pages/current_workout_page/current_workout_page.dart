import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/internal/bloc/current_workout/current_workout_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/workout_set_with_active_title.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CurrentWorkoutPage extends StatefulWidget {
  const CurrentWorkoutPage({super.key});

  @override
  State<CurrentWorkoutPage> createState() => _CurrentWorkoutPageState();
}

class _CurrentWorkoutPageState extends State<CurrentWorkoutPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int activeTitle = -1;

  @override
  void initState() {
    super.initState();
    context.read<CurrentWorkoutCubit>().getCurrentTraining();
  }

  @override
  Widget build(BuildContext context) {
    final currentWorkoutBloc = context.read<CurrentWorkoutCubit>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery
            .of(context)
            .padding
            .top + 20,
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
      body: Form(
        key: _formKey,
        child: BlocBuilder<CurrentWorkoutCubit, CurrentWorkoutState>(
          builder: (context, state) {
            state.whenOrNull(
              emptyValueIndex: (index){
                activeTitle = index;
              },
            );
            final training = currentWorkoutBloc.workout.listExercise;
            return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        itemCount: training.length,
                        onReorderStart: (_){
                          setState(() {
                            activeTitle = -1;
                          });
                        },
                        itemBuilder: (context, index) {
                          final exercise = training[index];
                          if (exercise is ExerciseSet) {
                            return GestureDetector(
                              key: Key('$index'),
                              onTap: (){
                                _formKey.currentState!.validate();
                                setState(() {
                                  if(activeTitle == -1){
                                    activeTitle = index;
                                  } else{
                                    if(!training[activeTitle].isNotValid){
                                      if(activeTitle == index){
                                        activeTitle = -1;
                                      }
                                      else{
                                        activeTitle = index;
                                      }
                                      currentWorkoutBloc.setWorkoutListExercise(training);
                                    }
                                  }
                                });
                              },
                              child: (activeTitle == index) ? WorkoutSetWithActiveTitle(
                                title: exercise.title,
                                setCount: exercise.setCount,
                                repetitionsCount: exercise.repetitionsCount,
                                onChanged: (title, set, repetition) {
                                  exercise.title = title;
                                  exercise.setCount = set;
                                  exercise.repetitionsCount = repetition;
                                  training[index] = exercise;
                                },
                              ) : Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: boxShadow,
                                    color: AppColors.primaryButtonColor
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(exercise.title),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Подходов: ${exercise.setCount}'),
                                        Text('Повторений: ${exercise.repetitionsCount}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          currentWorkoutBloc.onReorder(oldIndex, newIndex);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            currentWorkoutBloc.addNewExerciseSet(training);
                          }
                        },
                        child: SvgPicture.asset(
                          'images/plus.svg',
                          height: 36,
                          colorFilter: const ColorFilter.mode(
                              AppColors.grey,
                              BlendMode.srcIn
                          ),
                        ),
                      )
                    ],
                  ),
                )
            );
          },
        ),
      ),
    );
  }
}
