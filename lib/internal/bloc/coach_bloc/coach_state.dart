part of 'coach_bloc.dart';

@freezed
class CoachState with _$CoachState {
  const factory CoachState.initial() = _Initial;

  const factory CoachState.loading() = _Loading;

  const factory CoachState.error({required String errorMessage}) = _Error;

  const factory CoachState.success() = _Success;

  const factory CoachState.removeSuccess() = _RemoveSuccess;

  const factory CoachState.coachSearchList({
    required List<AppUser> coachSearchList,
  }) = _CoachSearchList;

  const factory CoachState.coachIsNull() = _CoachIsNull;
  const factory CoachState.startScheduledWorkout() = _StartScheduledWorkout;
}
