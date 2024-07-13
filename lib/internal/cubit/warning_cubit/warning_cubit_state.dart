part of 'warning_cubit.dart';

enum ConnectionStatus { unknown, connected, disconnected }

@freezed
abstract class WarningCubitState with _$WarningCubitState {
  const factory WarningCubitState.unknown() = Unknown;
  const factory WarningCubitState.disconnected() = Disconnected;
  const factory WarningCubitState.connected() = Connected;
  const factory WarningCubitState.saveInfo() = SaveInfo;
  const factory WarningCubitState.errorSaveInfo() = ErrorSaveInfo;
}
