part of 'user_info_bloc.dart';

@freezed
class UserInfoEvent with _$UserInfoEvent {
  const factory UserInfoEvent.singOut() = _SingOut;
  const factory UserInfoEvent.update({
     String? name,
     String? email,
     bool? isCoach,
     double? weightNow,
     double? weightGoal,
     DateTime? birthday,
     int? height,
     int? caloriesGoal,
     int? fatsGoal,
     int? carbohydratesGoal,
     int? proteinGoal,
     String? sexValue,
  }) = _Update;
}


// abstract class UserInfoEvent {}
//
// ///Остановить обновление состояния. В противном случае, поля изменения
// ///личных данных постоянно обновляются
// class StopBuildUserInfoEvent extends UserInfoEvent {}
//
// class UserSignOutEvent extends UserInfoEvent {}
//
// class UserEditingInfoEvent extends UserInfoEvent {
//   final String? name;
//   final String? email;
//   final double? weightNow;
//   final double? weightGoal;
//   final DateTime? birthday;
//   final int? height;
//   final int? caloriesGoal;
//   final int? fatsGoal;
//   final int? carbohydratesGoal;
//   final int? proteinGoal;
//   final String? sexValue;
//
//   UserEditingInfoEvent(
//       {
//         this.name,
//         this.email,
//         this.weightNow,
//         this.weightGoal,
//         this.birthday,
//         this.height,
//         this.caloriesGoal,
//         this.fatsGoal,
//         this.carbohydratesGoal,
//         this.proteinGoal,
//         this.sexValue
//       });
// }

// ///Получение актуального [localUser]
// class LocalUserInfoEvent extends UserInfoEvent {}

