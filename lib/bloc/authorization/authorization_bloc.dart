import 'package:app1/enums/authorizationStatus.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app1/service/UserSirvice.dart';
part 'authorization_event.dart';
part 'authorization_state.dart';


class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    print(state);
    on<AuthorizationEvent>(_onAuthorization);
  }

  Future<void> _onAuthorization(AuthorizationEvent event, Emitter<AuthorizationState> emitter) async{
    emitter(AuthorizationLoading());
    final AuthorizationStatus status = await authorization(event.email, event.password);
    print(status);
    switch (status){
      case AuthorizationStatus.successful:
        emitter(AuthorizationSuccessful());
        break;
      default:
        emitter(AuthorizationError(error: status.authorizationStatus));
        break;
    }
  }
}
