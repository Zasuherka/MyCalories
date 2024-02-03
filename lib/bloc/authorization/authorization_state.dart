part of 'authorisation_bloc.dart';

@immutable
abstract class AuthorizationState {}

class AuthorizationInitial implements AuthorizationState {}

class UserIsLogged implements AuthorizationState {}

class UserIsNotLogged implements AuthorizationState {}

class AuthorizationLoading implements AuthorizationState {}

class AuthorizationError implements AuthorizationState {
  final String error;

  AuthorizationError({required this.error});
}

