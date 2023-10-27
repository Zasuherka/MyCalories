import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app1/service/UserSirvice.dart';
part 'authorization_event.dart';
part 'authorization_state.dart';


class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<AuthorizationEvent>(_onAuthorization);
  }

  Future<void> _onAuthorization(AuthorizationEvent event, Emitter<AuthorizationState> emitter) async{
    emitter(AuthorizationLoading());
    final AuthorizationState state = await authorization(event.email, event.password);
    emitter(state);
  }
}
