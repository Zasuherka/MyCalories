import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:app1/internal/bloc/registration/registration_event.dart';
import 'package:app1/domain/enums/registration_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'registration_state.dart';
part 'registration_bloc.freezed.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>
{

  final IUserRepository _userRepository;

  RegistrationBloc({required IUserRepository userRepository})
      : _userRepository = userRepository,
        super(const RegistrationState.initial()) {
    on<RegistrationEvent>(_onRegistration);
  }

  Future<void> _onRegistration(RegistrationEvent event, Emitter<RegistrationState> emitter) async {
    emitter(const RegistrationState.loading());
    final RegistrationStatus status = await _userRepository.register(event.email, event.name, event.password1, event.password2);
    if (status == RegistrationStatus.successful){
      emitter(const RegistrationState.successful());
    }
    else{
      emitter(RegistrationState.error(error: status.registrationStatus));
    }
  }
}