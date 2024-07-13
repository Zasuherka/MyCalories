part of 'workout_cubit.dart';

@freezed
class WorkoutState with _$WorkoutState{
  const factory WorkoutState.initial() = _Initial;
  const factory WorkoutState.loading() = _Loading;
  const factory WorkoutState.success() = _Success;
  const factory WorkoutState.successWorkoutEnd() = _SuccessWorkoutEnd;
  const factory WorkoutState.workout({
    required Workout workout,
}) = _Workout;
  const factory WorkoutState.emptyValueIndex({required int index}) = _EmptyValueIndex;
  const factory WorkoutState.failure({
    required String errorMessage
  }) = _Failure;
  const factory WorkoutState.listExercise({
    required List<Exercise> listExercise
  }) = _ListExercise;
}

