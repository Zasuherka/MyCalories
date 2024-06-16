part of 'wards_bloc.dart';

@freezed
class WardsEvent with _$WardsEvent{
  const factory WardsEvent.getWardsListEvent() = GetWardsListEvent;

  const factory WardsEvent.getWardRequestsListEvent() = GetWardRequestsListEvent;

  const factory WardsEvent.updateLocalUserInfo() = UpdateLocalUserInfo;

  const factory WardsEvent.getInfoAboutWard({
    required String userId,
  }) = GetInfoAboutWard;

  const factory WardsEvent.getInfoAboutFoodDiaryWard({
    required DateTime dateTime,
  }) = GetInfoAboutFoodDiaryWard;

  const factory WardsEvent.removeWards({
    required AppUser appUser,
  }) = RemoveWards;

  const factory WardsEvent.replyWards({
    required AppUser appUser,
    required bool reply,
  }) = ReplyWards;
}
