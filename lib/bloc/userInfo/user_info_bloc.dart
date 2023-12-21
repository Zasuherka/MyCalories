import 'package:app1/enums/sex.dart';
import 'package:app1/objects/user.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:bloc/bloc.dart';
part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoInitial()) {
    on<LocalUserInfoEvent>(_localUserInfo);
    on<UserEditingInfoEvent>(_editingUserInfo);
    on<UserSingOutEvent>(_onSingOut);
    on<StopBuildUserInfoEvent>((StopBuildUserInfoEvent event, Emitter<UserInfoState> emitter)=>emitter(StopBuildUserInfoState()));
  }

  Future _editingUserInfo(UserEditingInfoEvent event, Emitter<UserInfoState> emitter) async {
    try{
      await updateUserInfo(
        email: event.email,
        name: event.name,
        weightNow: event.weightNow,
        weightGoal: event.weightGoal,
        height: event.height,
        birthday: event.birthday,
        carbohydratesGoal: event.carbohydratesGoal,
        caloriesGoal: event.caloriesGoal,
        proteinGoal: event.proteinGoal,
        fatsGoal: event.fatsGoal,
        sexValue: event.sexValue
      );
      emitter(UserInfoSuccessfulState());
    }
    catch(error){
      emitter(UserInfoErrorState('$error'));
    }
  }

  Future _localUserInfo(LocalUserInfoEvent event, Emitter<UserInfoState> emitter) async{
    if (localUser != null){
      emitter(LocalUserInfoState(localUser!));
    }
    else{
      emitter(UserInfoErrorState('localUser is null'));
    }
  }

  Future _onSingOut(UserSingOutEvent event, Emitter<UserInfoState> emitter) async {
    await exitUser();
  }
}
