import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/current_workout_page/widgets/current_workout_end_dialog.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:app1/presentation/widgets/custom_buttons/primary_app_button.dart';
import 'package:app1/presentation/widgets/workout/plus_exercise_widget.dart';
import 'package:app1/presentation/widgets/workout/workout_cardio_active.dart';
import 'package:app1/presentation/widgets/workout/workout_round_set_active.dart';
import 'package:app1/presentation/widgets/workout/workout_set_active.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CurrentWorkoutPage extends StatefulWidget {
  const CurrentWorkoutPage({super.key});

  @override
  State<CurrentWorkoutPage> createState() => _CurrentWorkoutPageState();
}

class _CurrentWorkoutPageState extends State<CurrentWorkoutPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int activeIndex = -1;

  final TextEditingController _titleTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WorkoutCubit>().getCurrentTraining();
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutCubit currentWorkoutCubit = context.read<WorkoutCubit>();
    return BlocConsumer<WorkoutCubit, WorkoutState>(
      listener: (context, state){
        state.whenOrNull(
          workout: (workout){
            _titleTextController.text = workout.title;
          },
          successWorkoutEnd: () => context.router.popForced(),
        );
      },
      builder: (context, state){
        state.whenOrNull(
          emptyValueIndex: (index){
            activeIndex = index;
          },
        );
        final List<Exercise> training = [];
        training.addAll(currentWorkoutCubit.currentWorkout.listExercise);
        return GestureDetector(
          onTap: () {
            if(!currentWorkoutCubit.currentWorkoutIsNull) currentWorkoutCubit.setWorkoutListExercise();
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'Тренировка',
              withoutRightIcon: currentWorkoutCubit.currentWorkoutIsNull,
              rightOnTap: (){
                currentWorkoutCubit.setWorkoutListExercise();
                showDialog(context: context, builder: (context) => const CurrentWorkoutEndDialog());
              },
            ),
            body: Form(
                key: _formKey,
                child: state.maybeMap(
                    loading: (_) => Center(
                      child: Image.asset(
                        'images/bouncing-circles.gif',
                        height: 100,
                      ),
                    ),
                    orElse: (){
                      if(currentWorkoutCubit.currentWorkoutIsNull){
                        return Center(
                          child: PrimaryAppButton(
                            onTap: (){
                              context.read<WorkoutCubit>().setCurrentWorkout();
                              // context.router.popForced();
                            },
                            height: 50,
                            borderRadius: 15,
                            withColor: false,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            child: Text(
                              'Начать тренировку',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppColors.primaryTextColor
                              ),
                            ),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(7),
                              child: TextField(
                                controller: _titleTextController,
                                onEditingComplete: (){
                                  currentWorkoutCubit.setTitleWorkout(_titleTextController.text);
                                },
                                onTap: (){
                                  setState(() {
                                    activeIndex = -1;
                                  });
                                },
                                onTapOutside: (_){
                                  FocusScope.of(context).unfocus();
                                  currentWorkoutCubit.setTitleWorkout(_titleTextController.text);
                                },
                                maxLength: 20,
                                decoration: InputDecoration(
                                    counterText: '',
                                    suffixIcon: GestureDetector(
                                      onTap: () => _titleTextController.text = '',
                                      child: const Icon(
                                        Icons.close,
                                        color: AppColors.colorForHintText,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.turquoise
                                        ),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.turquoise
                                        ),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    hintText: 'Название',
                                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.colorForHintText
                                    )
                                ),
                              ),
                            ),
                            ReorderableListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: training.length,
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              onReorderStart: (_){
                                setState(() {
                                  activeIndex = -1;
                                });
                              },
                              proxyDecorator: (child, index, animation){
                                return Material(
                                  color: Colors.transparent,
                                  child: DecoratedBox(
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
                                  ),
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
                                          ? WorkoutSetActive(
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
                                                Text(
                                                    'Повторений: ${exercise.repetitionsCount}'),
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
                                    onDismissed: (_) {
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
                                      onTap: () {
                                        _formKey.currentState!.validate();
                                        setState(() {
                                          if (activeIndex == -1) {
                                            currentWorkoutCubit.setCurrentExerciseIndex(index);
                                            activeIndex = index;
                                          } else {
                                            if (!training[activeIndex].isNotValid) {
                                              if (activeIndex == index) {
                                                activeIndex = -1;
                                              } else {
                                                currentWorkoutCubit.setCurrentExerciseIndex(index);
                                                activeIndex = index;
                                              }
                                              currentWorkoutCubit.setWorkoutListExercise(training);
                                            }
                                          }
                                        });
                                      },
                                      child: (activeIndex == index)
                                          ? WorkoutRoundSetActive(
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
                                    onDismissed: (_) {
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
                                      onTap: () {
                                        _formKey.currentState!.validate();
                                        setState(() {
                                          if (activeIndex == -1) {
                                            currentWorkoutCubit.setCurrentExerciseIndex(index);
                                            activeIndex = index;
                                          } else {
                                            if (!training[activeIndex].isNotValid) {
                                              if (activeIndex == index) {
                                                activeIndex = -1;
                                              } else {
                                                currentWorkoutCubit.setCurrentExerciseIndex(index);
                                                activeIndex = index;
                                              }
                                              currentWorkoutCubit.setWorkoutListExercise(training);
                                            }
                                          }
                                        });
                                      },
                                      child: (activeIndex == index)
                                          ? WorkoutCardioActive(
                                        title: exercise.title,
                                        count: exercise.count,
                                        onChanged: (title, count) {
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
                                setState(() {
                                  if (oldIndex < newIndex) {
                                    newIndex -= 1;
                                  }
                                  final item = training.removeAt(oldIndex);
                                  training.insert(newIndex, item);
                                });
                                currentWorkoutCubit.setWorkoutListExercise(training);
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
                    })
            ),
          ),
        );
      },
    );
  }
}
