part of 'authorization_bloc.dart';

@freezed
class AuthorizationEvent with _$AuthorizationEvent {
  const factory AuthorizationEvent.auth({
    required String email,
    required String password
  }) = _Auth;
}