import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/i_coach_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';

part 'coach_event.dart';
part 'coach_state.dart';
part 'coach_bloc.freezed.dart';

class CoachBloc extends Bloc<CoachEvent, CoachState> {

  CoachBloc({required IUserRepository userRepository, required ICoachRepository coachRepository})
      : _userRepository = userRepository,
        _coachRepository = coachRepository,
        super(const CoachState.initial()) {
    on<CoachEvent>((event, emit) async {
      await event.map(
          getScheduledWorkout: (_) async => await _getInfoAboutScheduledWorkout(emit),
          getCoachInfo: (_) async => await _getCoachInfo(emit),
          searchCoach: (value) async => await _searchCoach(emit, value.searchText),
          coachRequest: (value) async => await _coachRequest(emit, value.coach),
          updateLocalUserInfo: (_) async => await _updateLocalUserInfo(emit),
          getCoachCollectionViewList: (_) async => _getCoachCollectionViewList(emit),
          removeCoach: (_) async => _removeCoach(emit),
          startScheduledWorkoutEvent: (_) async => await _startScheduledWorkout(emit));
    }, transformer: restartable());
    localUser = _userRepository.localUser;
    coachId = localUser?.coachId;
    _userRepository.controller.stream.listen((event) {
      localUser = event;
      coachId = event?.coachId;
    });
  }

  final IUserRepository _userRepository;
  final ICoachRepository _coachRepository;
  AppUser? coach;
  String? coachId;
  List<AppUser> appUserList = [];
  List<CollectionView> collectionViewList = [];
  AppUser? localUser;

  Workout? scheduledWorkout;

  Future<void> _updateLocalUserInfo(Emitter<CoachState> emitter) async{
    emitter(const CoachState.loading());
    try{
      localUser = await _userRepository.updateLocalUserInfo();
      coachId = localUser?.coachId;
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

  Future<void> _getCoachCollectionViewList(Emitter<CoachState> emitter) async{
    if(coach == null) return;
    emitter(const CoachState.loading());
    collectionViewList = await _coachRepository.getCoachCollectionViewList(coach!.listCollectionsId);
    emitter(const CoachState.success());
  }

  Future<void> _removeCoach(Emitter<CoachState> emitter) async{
    if(coach == null) return;
    emitter(const CoachState.loading());
    try{
      await _coachRepository.removeCoach(coach!);
      localUser?.coachId = null;
      coachId = null;
      coach = null;
      emitter(const CoachState.removeSuccess());
    }
    catch(error){
      emitter(const CoachState.error(errorMessage: 'Не удалось отказаться от тренера'));
    }
  }

  Future<void> _getInfoAboutScheduledWorkout(Emitter<CoachState> emitter) async{
    emitter(const CoachState.loading());
    scheduledWorkout = await _coachRepository.getInfoAboutScheduledWorkout();
    emitter(const CoachState.success());
  }

  Future<void> _startScheduledWorkout(Emitter<CoachState> emitter) async{
    if(scheduledWorkout == null) return;
    emitter(const CoachState.loading());
    await _coachRepository.startScheduledWorkout(scheduledWorkout!);
    emitter(const CoachState.startScheduledWorkout());
  }
}
