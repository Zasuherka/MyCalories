import 'package:app1/bloc/registration/registration_event.dart';
import 'package:app1/bloc/registration/registration_state.dart';
import 'package:app1/enums/registrationStatus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/service/UserSirvice.dart';


class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>
{
  RegistrationBloc() : super(RegistrationInitial()){
    on<RegistrationEvent>(_onRegistration);
  }

  Future<void> _onRegistration(RegistrationEvent event, Emitter<RegistrationState> emitter) async {
    emitter(RegistrationLoading());
    final RegistrationStatus status = await register(event.email, event.name, event.password1, event.password2);
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