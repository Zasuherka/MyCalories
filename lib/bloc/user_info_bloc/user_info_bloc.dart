import 'package:app1/models/user.dart';
import 'package:app1/service/image_service.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:bloc/bloc.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {

  static final UserService _userService = UserService();
  static final ImageService _imageService = ImageService();

  AppUser? localUser;

  UserInfoBloc() : super(UserInfoInitial()) {
    on<UserEditingInfoEvent>(_editingUserInfo);
    on<UserSignOutEvent>(_onSignOut);
    localUser = _userService.localUser;
    UserService.controller.stream.listen((event) {
      localUser = event;
    });
  }

  Future _editingUserInfo(UserEditingInfoEvent event, Emitter<UserInfoState> emitter) async {
    try{
      await _userService.updateUserInfo(
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
    }
    catch(error){
      emitter(UserInfoErrorState('$error'));
    }
  }

  // Future _localUserInfo(LocalUserInfoEvent event, Emitter<UserInfoState> emitter) async{
  //   if (localUser != null){
  //     emitter(LocalUserInfoState(localUser!));
  //   }
  //   else{
  //     emitter(UserInfoErrorState('localUser is null'));
  //   }
  // }

  Future _onSignOut(UserSignOutEvent event, Emitter<UserInfoState> emitter) async {
    await _imageService.signOut();
    await _userService.exitUser();
  }
}
