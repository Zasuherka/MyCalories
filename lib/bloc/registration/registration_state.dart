abstract class RegistrationState{}

class RegistrationInitial implements RegistrationState {}

class RegistrationSuccessful implements RegistrationState {}


class RegistrationLoading implements RegistrationState {}

class RegistrationError implements RegistrationState {
  final String error;

  RegistrationError({required this.error});
}