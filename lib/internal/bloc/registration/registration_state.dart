part of 'registration_bloc.dart';

@freezed
class RegistrationState with _$RegistrationState{
  const factory RegistrationState.initial() = _Initial;
  const factory RegistrationState.successful() = _Successful;
  const factory RegistrationState.loading() = _Loading;
  const factory RegistrationState.error({
    required String error
  }) = _Error;
}

// abstract class RegistrationState{}
//
// class RegistrationInitial implements RegistrationState {}
//
// class RegistrationSuccessful implements RegistrationState {}
//
//
// class RegistrationLoading implements RegistrationState {}
//
// class RegistrationError implements RegistrationState {
//   final String error;
//
//   RegistrationError({required this.error});
// }