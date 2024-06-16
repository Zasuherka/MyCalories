part of 'wards_bloc.dart';

@freezed
class WardsEvent with _WardsEvent{
  const factory WardsEvent.getWardsList() = GetWardsList;

  const factory WardsEvent.getWardRequestsList() = GetWardRequestsList;

  const factory WardsEvent.updateLocalUserInfo() = UpdateLocalUserInfo;

  const factory WardsEvent.getInfoAboutWard({
    required String userId,
  }) = GetInfoAboutWard;

  const factory WardsEvent.removeWards({
    required AppUser appUser,
  }) = GetInfoAboutWard;

  const factory WardsEvent.replyWards({
    required AppUser appUser,
    required bool reply,
  }) = GetInfoAboutWard;
}
