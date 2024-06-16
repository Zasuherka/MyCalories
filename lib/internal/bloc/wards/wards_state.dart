part of 'wards_bloc.dart';

@freezed
class WardsState with _$WardsState {
  const factory WardsState.initial() = _Initial;

  const factory WardsState.loading() = Loading;

  const factory WardsState.error({required String errorMessage}) = _Error;

  const factory WardsState.success() = _Success;

  const factory WardsState.successRemoveWard() = _SuccessRemoveWard;

  const factory WardsState.successUpdateExercise() = SuccessUpdateExercise;

  const factory WardsState.successWorkoutEnd() = _SuccessWorkoutEnd;

  const factory WardsState.emptyValueIndex({required int index}) = _EmptyValueIndex;

  const factory WardsState.getWardsList({
    required List<AppUser> wardsList,
  }) = _GetWardsList;

  const factory WardsState.getWardRequestsList({
    required List<AppUser> wardRequestsList,
  }) = _GetWardRequestsList;
}
