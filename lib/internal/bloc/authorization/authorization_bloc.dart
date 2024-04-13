import 'dart:async';
import 'package:app1/domain/enums/authorization_status.dart';
import 'package:app1/domain/enums/local_yser_status.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';
part 'authorization_bloc.freezed.dart';



class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {

  final IUserRepository _userRepository = UserRepository();
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
    final AuthorizationStatus status = await _userRepository.authorization(email, password);
    print(status.authorizationStatus);
    if(status == AuthorizationStatus.successful){
      emitter(const AuthorizationState.successful());
      await Future.delayed(const Duration(milliseconds: 300));
      emitter(const AuthorizationState.initial());
    }
    else{
      emitter(AuthorizationState.error(error: status.authorizationStatus));
    }
  }
}
