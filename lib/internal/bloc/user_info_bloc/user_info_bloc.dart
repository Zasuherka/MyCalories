import 'package:app1/domain/model/user.dart';
import 'package:app1/data/repository/image_repository.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/repository/i_image_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';
part 'user_info_bloc.freezed.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {

  static final IUserRepository _userRepository = UserRepository();
  static final IImageRepository _imageRepository = ImageRepository();

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

    localUser = _userRepository.localUser;
    UserRepository.controller.stream.listen((event) {
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
      //emitter(const UserInfoState.loading());
      await _userRepository.updateUserInfo(
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
      await Future.delayed(const Duration(milliseconds: 100));
      emitter(const UserInfoState.initial());
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
    await _imageRepository.signOut();
    await _userRepository.logOutUser();
  }
}
