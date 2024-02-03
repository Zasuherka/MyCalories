import 'dart:async';
import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/enums/authorization_status.dart';
import 'package:app1/enums/localUserStatus.dart';
import 'package:app1/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app1/service/user_sirvice.dart';
part 'authorization_event.dart';
part 'authorization_state.dart';


class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {

  final UserService _userService = UserService();
  AppUser? localUser;
  LocalUserStatus localUserStatus = LocalUserStatus.load;

  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<AuthorizationUser>(_onAuthorization);

  }


  Future<void> _onAuthorization(AuthorizationUser event, Emitter<AuthorizationState> emitter) async{
    print('жмяк');
    final AuthorizationStatus status = await _userService.authorization(event.email, event.password);
    if(status == AuthorizationStatus.error){
      emitter(AuthorizationError(error: status.authorizationStatus));
    }
  }
}
