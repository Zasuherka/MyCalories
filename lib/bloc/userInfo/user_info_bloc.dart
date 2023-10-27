import 'package:app1/objects/user.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:bloc/bloc.dart';
part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoInitial()) {
    on<LocalUserInfoEvent>(_localUserInfo);
    on<UserEditingInfoEvent>(_editingUserInfo);
    on<StopBuildUserInfoEvent>((StopBuildUserInfoEvent event, Emitter<UserInfoState> emitter)=>emitter(StopBuildUserInfoState()));
  }

  Future _editingUserInfo(UserEditingInfoEvent event, Emitter<UserInfoState> emitter) async {
    await updateUserInfo(event.email, event.name, event.weightNow, event.weightDream,  event.height, event.birthday);
  }

  Future _localUserInfo(LocalUserInfoEvent event, Emitter<UserInfoState> emitter) async{
    if (localUser != null){
      emitter(LocalUserInfoState(localUser!));
    }
    else{
      emitter(UserInfoErrorState('localUser is null'));
      throw 'localUser is null';
    }
  }
}
