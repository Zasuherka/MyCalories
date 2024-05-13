import 'dart:async';

import 'package:app1/data/repository/workout_repository.dart';
import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/i_workout_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_workout_event.dart';
part 'current_workout_state.dart';
part 'current_workout_bloc.freezed.dart';

class CurrentWorkoutCubit extends Cubit<CurrentWorkoutState> {

  Workout workout = Workout(title: '', listExercise: []);
  final IWorkoutRepository _workoutRepository = WorkoutRepository();

  CurrentWorkoutCubit() : super(const CurrentWorkoutState.initial()) {}

  Future<void> setWorkoutListExercise(List<Exercise> list) async {
    workout.listExercise = list;
    print(list.first.title);
    await _workoutRepository.setCurrentWorkout(workout);
  }

  Future<void> onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    emit(const CurrentWorkoutState.loading());
    final item = workout.listExercise.removeAt(oldIndex);
    workout.listExercise.insert(newIndex, item);
    emit(const CurrentWorkoutState.success());
    await _workoutRepository.setCurrentWorkout(workout);
  }

  Future<void> addNewExerciseSet(List<Exercise> list) async {
    for(int i = 0; i < list.length; i++){
      if(list[i].isNotValid){
        emit(CurrentWorkoutState.emptyValueIndex(index: i));
        return;
      }
    }
    workout.listExercise = list;
    workout.listExercise.add(ExerciseSet());
    emit(const CurrentWorkoutState.loading());
    await _workoutRepository.setCurrentWorkout(workout);
    emit(const CurrentWorkoutState.success());
  }

  void getCurrentTraining() {
    try{
      _workoutRepository.getCurrentWorkout().listen((event) {
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
