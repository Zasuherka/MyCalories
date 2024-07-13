import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warning_cubit_state.dart';
part 'warning_cubit.freezed.dart';

class WarningCubit extends Cubit<WarningCubitState> {

  WarningCubit({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(const Unknown());

  final Connectivity _connectivity;

  void saveInfoWarning(){
    emit(const WarningCubitState.saveInfo());
  }

  void listedConnectivityChanged(){
    _connectivity.onConnectivityChanged.listen((checkConnectionState));
  }

  void checkConnectionState(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      emit(const WarningCubitState.connected());
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      emit(const WarningCubitState.connected());
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const WarningCubitState.disconnected());
    } else{
      emit(const WarningCubitState.unknown());
    }
  }

  Future<void> disposeSubscription() {
    return Future.value();
  }
}
