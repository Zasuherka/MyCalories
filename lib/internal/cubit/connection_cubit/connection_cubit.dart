import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_cubit_state.dart';
part 'connection_cubit.freezed.dart';

class ConnectionCubit extends Cubit<ConnectionCubitState> {
  final Connectivity connectivity;

  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  ConnectionCubit({required this.connectivity}) : super(const Unknown()) {
    connectivitySubscription = connectivity.onConnectivityChanged.listen((checkConnectionState));
  }

  void checkConnectionState(List<ConnectivityResult> connectivityResult) {

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      emit(const ConnectionCubitState.connected());
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      emit(const ConnectionCubitState.connected());
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const ConnectionCubitState.disconnected());
    } else{
      emit(const ConnectionCubitState.unknown());
    }
  }

  Future<void> disposeSubscription() {
    connectivitySubscription.cancel();
    return Future.value();
  }
}
