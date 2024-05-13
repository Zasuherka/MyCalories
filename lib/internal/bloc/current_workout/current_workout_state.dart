part of 'current_workout_bloc.dart';

@freezed
class CurrentWorkoutState with _$CurrentWorkoutState{
  const factory CurrentWorkoutState.initial() = _Initial;
  const factory CurrentWorkoutState.loading() = _Loading;
  const factory CurrentWorkoutState.success() = _Success;
  const factory CurrentWorkoutState.emptyValueIndex({required int index}) = _EmptyValueIndex;
  const factory CurrentWorkoutState.failure({
    required String errorMessage
  }) = _Failure;
  const factory CurrentWorkoutState.listExercise({
    required List<Exercise> listExercise
  }) = _ListExercise;
}

