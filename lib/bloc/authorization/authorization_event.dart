part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationState {}

class AuthorizationInitial implements AuthorizationState {}

class AuthorizationSuccessful implements AuthorizationState {}

class AuthorizationLoading implements AuthorizationState {}

class AuthorizationError implements AuthorizationState {
  final String error;

  AuthorizationError({required this.error});
}