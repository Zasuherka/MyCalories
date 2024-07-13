part of 'wards_bloc.dart';

@freezed
class WardsEvent with _$WardsEvent{
  const factory WardsEvent.getWardsListEvent() = GetWardsListEvent;

  const factory WardsEvent.getWardRequestsListEvent() = GetWardRequestsListEvent;

  const factory WardsEvent.updateLocalUserInfo() = UpdateLocalUserInfo;

  const factory WardsEvent.getInfoAboutWard({
    required String userId,
  }) = GetInfoAboutWard;

  const factory WardsEvent.setCurrentExerciseIndex({
    required int index,
  }) = SetCurrentExerciseIndex;

  const factory WardsEvent.setWorkoutListExercise({
    List<Exercise>? list,
  }) = SetWorkoutListExercise;

  const factory WardsEvent.currentWorkoutEnd() = CurrentWorkoutEnd;

  const factory WardsEvent.completedWorkoutList() = CompletedWorkoutList;

  const factory WardsEvent.onReorder({
    required int oldIndex,
    required int newIndex,
  }) = OnReorder;

  const factory WardsEvent.deleteExercise({
    required int index,
  }) = DeleteExercise;

  const factory WardsEvent.addNewExerciseSet({
    required List<Exercise> list,
    required ExerciseCase exerciseCase,
  }) = AddNewExerciseSet;

  const factory WardsEvent.setCurrentRoundSet({
    required List<PhysicalActivity> list,
    required String title,
    required String setCount,
    bool? addNewPhysicalActivity,
    int? removeIndex,
  }) = SetCurrentRoundSet;

  const factory WardsEvent.getInfoAboutFoodDiaryWard({
    required DateTime dateTime,
  }) = GetInfoAboutFoodDiaryWard;

  const factory WardsEvent.removeWards() = RemoveWards;

  const factory WardsEvent.replyWards({
    required AppUser appUser,
    required bool reply,
  }) = ReplyWards;
}
