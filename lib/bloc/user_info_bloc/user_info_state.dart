part of 'user_info_bloc.dart';

abstract class UserInfoState {}

class UserInfoInitial extends UserInfoState {}

class UserInfoSuccessfulState extends UserInfoState {}

class LocalUserInfoState extends UserInfoState {}

// class LocalUserInfoState extends UserInfoState {
//   final AppUser appUser;
//
//   LocalUserInfoState(this.appUser);
// }

class UserInfoErrorState extends UserInfoState {
  final String error;

  UserInfoErrorState(this.error);
}