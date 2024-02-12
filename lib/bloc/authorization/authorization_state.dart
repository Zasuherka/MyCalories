part of 'authorization_bloc.dart';

@freezed
class AuthorizationState with _$AuthorizationState {
  const factory AuthorizationState.initial() = _Initial;
  const factory AuthorizationState.successful() = _Logged;
  const factory AuthorizationState.loading() = _Loading;
  const factory AuthorizationState.error({
    required String error
  }) = _Error;
}

// @immutable
// abstract class AuthorizationState {}
//
// class AuthorizationInitial implements AuthorizationState {}
//
// class UserIsLogged implements AuthorizationState {}
//
// class UserIsNotLogged implements AuthorizationState {}
//
// class AuthorizationLoading implements AuthorizationState {}
//
// class AuthorizationError implements AuthorizationState {
//   final String error;
//
//   AuthorizationError({required this.error});
// }

