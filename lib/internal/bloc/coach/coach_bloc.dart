import 'package:app1/data/repositories/user_repository.dart';
import 'package:app1/domain/repositories/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coach_event.dart';
part 'coach_state.dart';
part 'coach_bloc.freezed.dart';

class CoachBloc extends Bloc<CoachEvent, CoachState> {

  final IUserRepository _userRepository = UserRepository();
  String? coachId;

  CoachBloc() : super(const CoachState.initial()) {
    on<CoachEvent>((event, emit) async {
      await event.map(
          getCoachInfo: (_) async => await _getCoachInfo(emit)
      );
    }, transformer: restartable());

    coachId = _userRepository.localUser?.coachId;
    UserRepository.controller.stream.listen((event) {
      coachId = event?.coachId;
    });
  }

  Future<void> _getCoachInfo(Emitter<CoachState> emitter) async{
    if(coachId == null) emitter(const CoachState.coachIsNull());
  }
}
