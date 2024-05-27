import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/internal/cubit/current_workout/current_workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/plus_exercise_widget.dart';
import 'package:app1/presentation/widgets/workout/workout_cardio_with_active_title.dart';
import 'package:app1/presentation/widgets/workout/workout_round_set_with_active_title.dart';
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
  int activeIndex = -1;

  @override
  void initState() {
    super.initState();
    context.read<CurrentWorkoutCubit>().getCurrentTraining();
  }

  @override
  Widget build(BuildContext context) {
    final currentWorkoutCubit = context.read<CurrentWorkoutCubit>();
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
                activeIndex = index;
              },
            );
            final List<Exercise> training = [];
            training.addAll(currentWorkoutCubit.workout.listExercise);
            return SingleChildScrollView(
              child: Column(
                children: [
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: training.length,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                    onReorderStart: (_){
                      setState(() {
                        activeIndex = -1;
                      });
                    },
                    proxyDecorator: (child, index, animation){
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: AppColors.dark.withOpacity(0.35),
                                blurRadius: 10,
                                spreadRadius: 2
                            )
                          ]
                        ),
                          child: child
                      );
                    },
                    itemBuilder: (context, index) {
                      final exercise = training[index];
                      if (exercise is ExerciseSet) {
                        return Dismissible(
                          key: Key(exercise.hashCode.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_){
                            training.removeAt(index);
                            currentWorkoutCubit.deleteExercise(index);
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            height: 77,
                            child: const Icon(
                              size: 35,
                              Icons.delete,
                              color: AppColors.red,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              _formKey.currentState!.validate();
                              setState(() {
                                if(activeIndex == -1){
                                  currentWorkoutCubit.setCurrentExerciseIndex(index);
                                  activeIndex = index;
                                } else{
                                  if(!training[activeIndex].isNotValid){
                                    if(activeIndex == index){
                                      activeIndex = -1;
                                    }
                                    else{
                                      currentWorkoutCubit.setCurrentExerciseIndex(index);
                                      activeIndex = index;
                                    }
                                    currentWorkoutCubit.setWorkoutListExercise(training);
                                  }
                                }
                              });
                            },
                            child: (activeIndex == index)
                                ? WorkoutSetWithActiveTitle(
                                    title: exercise.title,
                                    setCount: exercise.setCount,
                                    repetitionsCount: exercise.repetitionsCount,
                                    onChanged: (title, set, repetition) {
                                      exercise.title = title;
                                      exercise.setCount = set;
                                      exercise.repetitionsCount = repetition;
                                      training[index] = exercise;
                                    },
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: boxShadow,
                                        color: AppColors.primaryButtonColor),
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
                          ),
                        );
                      } else
                      if(exercise is ExerciseRoundSet){
                        return Dismissible(
                          key: Key(exercise.hashCode.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_){
                            training.removeAt(index);
                            currentWorkoutCubit.deleteExercise(index);
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            height: 77,
                            child: const Icon(
                              size: 35,
                              Icons.delete,
                              color: AppColors.red,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              _formKey.currentState!.validate();
                              setState(() {
                                if(activeIndex == -1){
                                  currentWorkoutCubit.setCurrentExerciseIndex(index);
                                  activeIndex = index;
                                } else{
                                  if(!training[activeIndex].isNotValid){
                                    if(activeIndex == index){
                                      activeIndex = -1;
                                    }
                                    else{
                                      currentWorkoutCubit.setCurrentExerciseIndex(index);
                                      activeIndex = index;
                                    }
                                    currentWorkoutCubit.setWorkoutListExercise(training);
                                  }
                                }
                              });
                            },
                            child: (activeIndex == index)
                                ? WorkoutRoundSetWithActiveTitle(
                                    indexExercise: index,
                                    onValidate: () =>
                                        _formKey.currentState?.validate() ?? false,
                                    onChanged: (title, set, list) {
                                      exercise.title = title;
                                      exercise.setCount = set;
                                      training[index] = exercise;
                                    },
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: boxShadow,
                                        color: AppColors.primaryButtonColor),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(exercise.title),
                                        Text('Кругов: ${exercise.setCount}'),
                                      ],
                                    ),
                                  ),
                          ),
                        );
                      } else
                      if(exercise is ExerciseCardio){
                        return Dismissible(
                          key: Key(exercise.hashCode.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_){
                            training.removeAt(index);
                            currentWorkoutCubit.deleteExercise(index);
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            height: 77,
                            child: const Icon(
                              size: 35,
                              Icons.delete,
                              color: AppColors.red,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              _formKey.currentState!.validate();
                              setState(() {
                                if(activeIndex == -1){
                                  currentWorkoutCubit.setCurrentExerciseIndex(index);
                                  activeIndex = index;
                                } else{
                                  if(!training[activeIndex].isNotValid){
                                    if(activeIndex == index){
                                      activeIndex = -1;
                                    }
                                    else{
                                      currentWorkoutCubit.setCurrentExerciseIndex(index);
                                      activeIndex = index;
                                    }
                                    currentWorkoutCubit.setWorkoutListExercise(training);
                                  }
                                }
                              });
                            },
                            child: (activeIndex == index)
                                ? WorkoutCardioWithActiveTitle(
                                    title: exercise.title,
                                    count: exercise.count,
                                    onChanged: (title, count){
                                      exercise.title = title;
                                      exercise.count = count;
                                      training[index] = exercise;
                                    },
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: boxShadow,
                                        color: AppColors.primaryButtonColor),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(exercise.title),
                                        Text('Минут/раз: ${exercise.count}'),
                                      ],
                                    ),
                                  ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                    onReorder: (int oldIndex, int newIndex) {
                      currentWorkoutCubit.onReorder(oldIndex, newIndex);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  PlusExerciseWidget(
                      isActive: () => _formKey.currentState?.validate() ?? false,
                      training: training)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
