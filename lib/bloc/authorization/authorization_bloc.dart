import 'dart:async';
import 'package:app1/enums/authorization_status.dart';
import 'package:app1/enums/localUserStatus.dart';
import 'package:app1/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';
part 'authorization_bloc.freezed.dart';



class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {

  final UserService _userService = UserService();
  AppUser? localUser;
  LocalUserStatus localUserStatus = LocalUserStatus.load;

  AuthorizationBloc() : super(const AuthorizationState.initial()) {
    on<AuthorizationEvent>((event, emit) async {
      await event.when(
          auth: (email, password) => _authorization(email, password, emit)
      );
    });
  }


  Future<void> _authorization(String email, String password, Emitter<AuthorizationState> emitter) async{
    emitter(const AuthorizationState.loading());
    final AuthorizationStatus status = await _userService.authorization(email, password);
    if(status == AuthorizationStatus.successful){
      emitter(const AuthorizationState.successful());
      const AuthorizationState.initial();
    }
    else{
      emitter(AuthorizationState.error(error: status.authorizationStatus));
    }
  }
}
