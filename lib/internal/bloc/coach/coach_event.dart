part of 'coach_bloc.dart';

@freezed
class CoachEvent with _$CoachEvent{
  const factory CoachEvent.getCoachInfo() = _GetCoachInfo;
  const factory CoachEvent.searchCoach({required String searchText}) = _SearchCoach;
  const factory CoachEvent.coachRequest({required AppUser coach}) = _CoachRequest;
  const factory CoachEvent.updateLocalUserInfo() = _UpdateLocalUserInfo;
}