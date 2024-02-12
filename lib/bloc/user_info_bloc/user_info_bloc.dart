import 'package:app1/models/user.dart';
import 'package:app1/service/image_service.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';
part 'user_info_bloc.freezed.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {

  static final UserService _userService = UserService();
  static final ImageService _imageService = ImageService();

  AppUser? localUser;

  UserInfoBloc() : super(const UserInfoState.initial()) {
    on<UserInfoEvent>((event, emit) async {
      await event.when(
          singOut: () => _signOut(emit),
          update: (name, email, weightNow, weightGoal, birthday,
                  height, caloriesGoal, fatsGoal, carbohydratesGoal,
                  proteinGoal, sexValue) =>
              _updateUserInfo(name, email, weightNow, weightGoal,
                  birthday, height, caloriesGoal, fatsGoal,
                  carbohydratesGoal, proteinGoal, sexValue, emit));
    });

    localUser = _userService.localUser;
    UserService.controller.stream.listen((event) {
      localUser = event;
    });
  }

  Future _updateUserInfo(
      String? name,
      String? email,
      double? weightNow,
      double? weightGoal,
      DateTime? birthday,
      int? height,
      int? caloriesGoal,
      int? fatsGoal,
      int? carbohydratesGoal,
      int? proteinGoal,
      String? sexValue,
      Emitter<UserInfoState> emitter) async {

    try{
      await _userService.updateUserInfo(
        email: email,
        name: name,
        weightNow: weightNow,
        weightGoal: weightGoal,
        height: height,
        birthday: birthday,
        carbohydratesGoal: carbohydratesGoal,
        caloriesGoal: caloriesGoal,
        proteinGoal: proteinGoal,
        fatsGoal: fatsGoal,
        sexValue: sexValue
      );
      emitter(const UserInfoState.successful());
    }
    catch(error){
      emitter(UserInfoState.error(error: error.toString()));
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

  Future _signOut(Emitter<UserInfoState> emitter) async {
    await _imageService.signOut();
    await _userService.logOutUser();
  }
}
