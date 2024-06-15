import 'package:app1/data/repository/coach_repository.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coach_event.dart';
part 'coach_state.dart';
part 'coach_bloc.freezed.dart';

class CoachBloc extends Bloc<CoachEvent, CoachState> {

  final IUserRepository _userRepository = UserRepository();
  final CoachRepository _coachRepository = CoachRepository();
  AppUser? coach;
  String? coachId;
  List<AppUser> appUserList = [];
  AppUser? localUser;

  CoachBloc() : super(const CoachState.initial()) {
    on<CoachEvent>((event, emit) async {
      await event.map(
        getCoachInfo: (_) async => await _getCoachInfo(emit),
        searchCoach: (value) async => await _searchCoach(emit, value.searchText),
        coachRequest: (value) async => await _coachRequest(emit, value.coach),
        updateLocalUserInfo: (_) async => await _updateLocalUserInfo(emit),
      );
    }, transformer: restartable());
    localUser = _userRepository.localUser;
    coachId = localUser?.coachId;
    UserRepository.controller.stream.listen((event) {
      localUser = event;
      coachId = event?.coachId;
    });
  }

  Future<void> _updateLocalUserInfo(Emitter<CoachState> emitter) async{
    emitter(const CoachState.loading());
    try{
      localUser = await _userRepository.updateLocalUserInfo();
      emitter(const CoachState.success());
    }
    catch(error){
      emitter(const CoachState.error(errorMessage: 'Не удалось обновить информацию о localUser'));
    }
  }

  Future<void> _getCoachInfo(Emitter<CoachState> emitter) async{
    emitter(const CoachState.loading());
    if(coachId == null){
      emitter(const CoachState.coachIsNull());
      return;
    }
    try{
      coach = await _coachRepository.getCoachInfo(coachId!);
      emitter(const CoachState.success());
    }
    catch(error){
      emitter(const CoachState.error(errorMessage: 'Не удалось получить информацию о тренере'));
    }
  }

  Future<void> _coachRequest(Emitter<CoachState> emitter, AppUser coach) async{
    emitter(const CoachState.loading());
    try{
      await _coachRepository.requestCoach(coach);
      emitter(const CoachState.success());
    }
    catch(error){
      emitter(const CoachState.error(errorMessage: ''));
    }
  }

  Future<void> _searchCoach(Emitter<CoachState> emitter, String searchText) async{
    emitter(const CoachState.loading());
    if(searchText == ''){
      appUserList.clear();
    } else{
      appUserList = await _coachRepository.searchCoach(searchText);
    }
    emitter(CoachState.coachSearchList(coachSearchList: appUserList));
  }
}
