part of 'coach_bloc.dart';

@freezed
class CoachState with _$CoachState{
  const factory CoachState.initial() = _Initial;
  const factory CoachState.coachIsNull() = _CoachIsNull;
}

