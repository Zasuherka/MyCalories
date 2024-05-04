part of 'connection_cubit.dart';

enum ConnectionStatus { unknown, connected, disconnected }

@freezed
abstract class ConnectionCubitState with _$ConnectionCubitState {
  const factory ConnectionCubitState.unknown() = Unknown;
  const factory ConnectionCubitState.disconnected() = Disconnected;
  const factory ConnectionCubitState.connected() = Connected;
}
