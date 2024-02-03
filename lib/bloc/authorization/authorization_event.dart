part of 'authorisation_bloc.dart';

class AuthorizationEvent {}

class AuthorizationUser extends AuthorizationEvent {
  final String email;
  final String password;

  AuthorizationUser(this.email, this.password);
}