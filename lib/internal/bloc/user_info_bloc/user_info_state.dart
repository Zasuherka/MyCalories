part of 'user_info_bloc.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const factory UserInfoState.initial() = _Initial;
  //const factory UserInfoState.loading() = _Loading;
  const factory UserInfoState.successful() = _Successful;
  const factory UserInfoState.info() = _InfoState;
  const factory UserInfoState.error({
    required String error
  }) = _Error;
}


// abstract class UserInfoState {}
//
// class UserInfoInitial extends UserInfoState {}
//
// class UserInfoSuccessfulState extends UserInfoState {}
//
// class LocalUserInfoState extends UserInfoState {}
//
// class UserInfoErrorState extends UserInfoState {
//   final String error;
//
//   UserInfoErrorState(this.error);
// }

//Пусть пока поспит в коментах
// class LocalUserInfoState extends UserInfoState {
//   final AppUser appUser;
//
//   LocalUserInfoState(this.appUser);
// }