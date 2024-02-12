import 'package:app1/bloc/registration/registration_event.dart';
import 'package:app1/enums/registration_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'registration_state.dart';
part 'registration_bloc.freezed.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>
{

  final UserService _userService = UserService();

  RegistrationBloc() : super(const RegistrationState.initial()){
    on<RegistrationEvent>(_onRegistration);
  }

  Future<void> _onRegistration(RegistrationEvent event, Emitter<RegistrationState> emitter) async {
    emitter(const RegistrationState.loading());
    final RegistrationStatus status = await _userService.register(event.email, event.name, event.password1, event.password2);
    print(status.registrationStatus);
    if (status == RegistrationStatus.successful){
      emitter(const RegistrationState.successful());
    }
    else{
      emitter(RegistrationState.error(error: status.registrationStatus));
    }
  }
}