part of 'coach_bloc.dart';

@freezed
class CoachEvent with _$CoachEvent{
  const factory CoachEvent.getCoachInfo() = _GetCoachInfo;
  const factory CoachEvent.searchCoach({required String searchText}) = _SearchCoach;
  const factory CoachEvent.coachRequest({required AppUser coach}) = _CoachRequest;
  const factory CoachEvent.updateLocalUserInfo() = _UpdateLocalUserInfo;
  const factory CoachEvent.getCoachCollectionViewList() = _GetCoachCollectionViewList;
  const factory CoachEvent.getScheduledWorkout() = _GetScheduledWorkout;
  const factory CoachEvent.removeCoach() = _RemoveCoach;
  const factory CoachEvent.startScheduledWorkoutEvent() = _StartScheduledWorkoutEvent;
}