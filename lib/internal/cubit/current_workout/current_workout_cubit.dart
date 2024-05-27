import 'dart:async';
import 'package:app1/data/repository/workout_repository.dart';
import 'package:app1/domain/enums/exercise_case.dart';
import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/i_workout_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_workout_state.dart';
part 'current_workout_cubit.freezed.dart';

class CurrentWorkoutCubit extends Cubit<CurrentWorkoutState> {

  Workout workout = Workout(title: '', listExercise: []);
  final IWorkoutRepository _workoutRepository = WorkoutRepository();
  int? currentExerciseIndex;

  CurrentWorkoutCubit() : super(const CurrentWorkoutState.initial());

  void setCurrentExerciseIndex(int index){
    emit(const CurrentWorkoutState.loading());
    currentExerciseIndex = index;
    emit(const CurrentWorkoutState.success());
  }

  Future<void> setWorkoutListExercise(List<Exercise> list) async {
    workout.listExercise = list;
    await setCurrentWorkout();
  }

  Future<void> onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = workout.listExercise.removeAt(oldIndex);
    workout.listExercise.insert(newIndex, item);
    await setCurrentWorkout();
  }

  Future<void> deleteExercise(int index)async{
    workout.listExercise.removeAt(index);
    await setCurrentWorkout();
  }

  Future<void> addNewExerciseSet(List<Exercise> list, ExerciseCase exerciseCase) async {
    for(int i = 0; i < list.length; i++){
      if(list[i].isNotValid){
        emit(CurrentWorkoutState.emptyValueIndex(index: i));
        return;
      }
    }
    workout.listExercise = list;
    switch(exerciseCase){
      case ExerciseCase.set:
        workout.listExercise.add(ExerciseSet());
      case ExerciseCase.roundSet:
        workout.listExercise.add(ExerciseRoundSet(physicalActivityList: []));
      case ExerciseCase.cardio:
        workout.listExercise.add(ExerciseCardio());
    }
    await setCurrentWorkout();
  }

  Future<void> setCurrentRoundSet(List<PhysicalActivity> list, String title, String setCount) async {
    if(currentExerciseIndex == null) return;
    final ExerciseRoundSet exerciseRoundSet = workout.listExercise[currentExerciseIndex!] as ExerciseRoundSet;
    exerciseRoundSet.physicalActivityList = list;
    exerciseRoundSet.title = title;
    exerciseRoundSet.setCount = setCount;
    workout.listExercise[currentExerciseIndex!] = exerciseRoundSet;
    await setCurrentWorkout();
  }

  Future<void> setCurrentWorkout() async {
    emit(const CurrentWorkoutState.loading());
    await _workoutRepository.setCurrentWorkout(workout);
    emit(const CurrentWorkoutState.success());
  }

  void getCurrentTraining() {
    try{
      _workoutRepository.getCurrentWorkout().listen((event) {
        emit(const CurrentWorkoutState.loading());
        workout = event;
        emit(const CurrentWorkoutState.success());
      });
    }
    catch(error){
      emit(const CurrentWorkoutState.failure(errorMessage: 'Ошибка загрузки списка'));
    }
  }

  Future<void> _addExercise(Emitter<CurrentWorkoutState> emitter) async {}

  Future<void> _deleteExercise(Emitter<CurrentWorkoutState> emitter) async {}
}
