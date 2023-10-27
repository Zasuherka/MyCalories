part of 'user_info_bloc.dart';

abstract class UserInfoEvent {}

///Остановить обновление состояния. В противном случае, поля изменения
///личных данных постоянно обновляются
class StopBuildUserInfoEvent extends UserInfoEvent {}

class UserEditingInfoEvent extends UserInfoEvent {
  final String? name;
  final String? email;
  final double? weightNow;
  final double? weightDream;
  final DateTime? birthday;
  final int? height;

  UserEditingInfoEvent(
      {required this.name, required this.email, required this.weightNow,
        required this.weightDream, required this.birthday, required this.height});
}

///Получение актуального [localUser]
class LocalUserInfoEvent extends UserInfoEvent {}

