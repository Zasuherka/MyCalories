part of 'user_info_bloc.dart';

abstract class UserInfoEvent {}

///Остановить обновление состояния. В противном случае, поля изменения
///личных данных постоянно обновляются
class StopBuildUserInfoEvent extends UserInfoEvent {}

class UserSingOutEvent extends UserInfoEvent {}

class UserEditingInfoEvent extends UserInfoEvent {
  final String? name;
  final String? email;
  final double? weightNow;
  final double? weightGoal;
  final DateTime? birthday;
  final int? height;
  final int? caloriesGoal;
  final int? fatsGoal;
  final int? carbohydratesGoal;
  final int? proteinGoal;
  final String? sexValue;

  UserEditingInfoEvent(
      {
        this.name,
        this.email,
        this.weightNow,
        this.weightGoal,
        this.birthday,
        this.height,
        this.caloriesGoal,
        this.fatsGoal,
        this.carbohydratesGoal,
        this.proteinGoal,
        this.sexValue
      });
}

///Получение актуального [localUser]
class LocalUserInfoEvent extends UserInfoEvent {}

