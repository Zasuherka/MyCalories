import 'dart:async';
import 'package:app1/domain/enums/exercise_case.dart';
import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/i_workout_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_state.dart';
part 'workout_cubit.freezed.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit({required IWorkoutRepository workoutRepository})
      : _workoutRepository = workoutRepository,
        super(const WorkoutState.initial());

  final IWorkoutRepository _workoutRepository;

  Workout currentWorkout = Workout(title: '', listExercise: []);

  List<Workout> completedWorkoutsList = [];

  late Workout completedWorkout;

  int? currentExerciseIndex;

  bool currentWorkoutIsNull = false;

  void setCurrentExerciseIndex(int index){
    currentExerciseIndex = index;
    emit(const WorkoutState.success());
  }

  Future<void> setWorkoutListExercise([List<Exercise>? list]) async {
    if(list != null) currentWorkout.listExercise = list;
    emit(const WorkoutState.success());
    await setCurrentWorkout();
  }

  Future<void> currentWorkoutEnd() async{
    emit(const WorkoutState.loading());
    await _workoutRepository.endCurrentWorkout(currentWorkout);
    currentWorkout = Workout(title: '', listExercise: []);
    currentWorkoutIsNull = true;
    emit(const WorkoutState.successWorkoutEnd());

  }

  Future<void> onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = currentWorkout.listExercise.removeAt(oldIndex);
    currentWorkout.listExercise.insert(newIndex, item);
    await setCurrentWorkout();
  }

  Future<void> deleteExercise(int index)async{
    currentWorkout.listExercise.removeAt(index);
    await setCurrentWorkout();
  }

  Future<void> addNewExerciseSet(List<Exercise> list, ExerciseCase exerciseCase) async {
    for(int i = 0; i < list.length; i++){
      if(list[i].isNotValid){
        currentExerciseIndex = i;
        emit(WorkoutState.emptyValueIndex(index: i));
        return;
      }
    }
    currentWorkout.listExercise = list;
    switch(exerciseCase){
      case ExerciseCase.set:
        currentWorkout.listExercise.add(ExerciseSet());
      case ExerciseCase.roundSet:
        currentWorkout.listExercise.add(ExerciseRoundSet(physicalActivityList: []));
      case ExerciseCase.cardio:
        currentWorkout.listExercise.add(ExerciseCardio());
    }
    await setCurrentWorkout();
  }

  Future<void> setCurrentRoundSet(List<PhysicalActivity> list, String title, String setCount) async {
    if(currentExerciseIndex == null) return;
    final ExerciseRoundSet exerciseRoundSet = currentWorkout.listExercise[currentExerciseIndex!] as ExerciseRoundSet;
    exerciseRoundSet.physicalActivityList = list;
    exerciseRoundSet.title = title;
    exerciseRoundSet.setCount = setCount;
    currentWorkout.listExercise[currentExerciseIndex!] = exerciseRoundSet;
    await setCurrentWorkout();
  }

  Future<void> setCurrentWorkout() async {
    await _workoutRepository.setCurrentWorkout(currentWorkout);
    emit(const WorkoutState.success());
  }

  Future<void> setTitleWorkout(String newTitle) async{
    currentWorkout.title = newTitle;
    await setCurrentWorkout();
  }

  void getCurrentTraining() {
    emit(const WorkoutState.loading());
    try{
      _workoutRepository.getCurrentWorkout().listen((event) {
        if(event == null){
          currentWorkoutIsNull = true;
        }
        else{
          currentWorkout = event;
          currentWorkoutIsNull = false;
        }
        emit(WorkoutState.workout(workout: currentWorkout));
      });
    }
    catch(error){
      emit(const WorkoutState.failure(errorMessage: 'Ошибка загрузки списка'));
    }
  }

  Future<void> getCompletedWorkoutsList() async{
    try{
      emit(const WorkoutState.loading());
      final completedWorkoutsList = await _workoutRepository.getCompletedWorkoutsList();
      this.completedWorkoutsList = completedWorkoutsList.reversed.toList();
      emit(const WorkoutState.success());
    }
    catch(error){
      emit(const WorkoutState.failure(errorMessage: 'Ошибка загрузки данных'));
    }
  }

  void setCompletedWorkout(Workout workout){
    completedWorkout = workout;
  }
}
