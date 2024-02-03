import 'package:app1/bloc/registration/registration_event.dart';
import 'package:app1/bloc/registration/registration_state.dart';
import 'package:app1/enums/registration_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/service/user_sirvice.dart';


class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>
{

  final UserService _userService = UserService();

  RegistrationBloc() : super(RegistrationInitial()){
    on<RegistrationEvent>(_onRegistration);
  }

  Future<void> _onRegistration(RegistrationEvent event, Emitter<RegistrationState> emitter) async {
    emitter(RegistrationLoading());
    print(event.password1);
    final RegistrationStatus status = await _userService.register(event.email, event.name, event.password1, event.password2);
    switch (status){
      case RegistrationStatus.successful:
        emitter(RegistrationSuccessful());
        break;
      default:
        emitter(RegistrationError(error: status.registrationStatus));
        break;
    }
  }
}
//Event то что приходит
//State состояние которое отдаём