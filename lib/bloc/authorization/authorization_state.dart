part of 'authorization_bloc.dart';

class AuthorizationEvent {
  final String email;
  final String password;

  AuthorizationEvent(this.email, this.password);
}

