part of 'current_workout_bloc.dart';

@freezed
class CurrentWorkoutEvent with _$CurrentWorkoutEvent {
  const factory CurrentWorkoutEvent.getCurrentTraining() = _GetCurrentTraining;
  const factory CurrentWorkoutEvent.addExercise({required Exercise exercise}) = _AddExercise;
  const factory CurrentWorkoutEvent.deleteExercise({required Exercise exercise}) = _DeleteCurrentTraining;
}
