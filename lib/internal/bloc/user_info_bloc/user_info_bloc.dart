import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_image_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';
part 'user_info_bloc.freezed.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {

  final IUserRepository _userRepository;
  final IImageRepository _imageRepository;

  AppUser? localUser;

  UserInfoBloc({required IUserRepository userRepository, required IImageRepository imageRepository}) :
        _userRepository = userRepository,
        _imageRepository = imageRepository,
        super(const UserInfoState.initial()) {
    on<UserInfoEvent>((event, emit) async {
      await event.map(
          singOut: (_) => _signOut(emit),
          update: (value) =>
              _updateUserInfo(value.name, value.email, value.isCoach, value.weightNow, value.weightGoal,
                  value.birthday, value.height, value.caloriesGoal, value.fatsGoal,
                  value.carbohydratesGoal, value.proteinGoal, value.sexValue, emit));
    });

    localUser = _userRepository.localUser;
    _userRepository.controller.stream.listen((event) {
      localUser = event;
    });
  }

  Future _updateUserInfo(
      String? name,
      String? email,
      bool? isCoach,
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
      emitter(const UserInfoState.loading());
      await _userRepository.updateUserInfo(
        email: email,
        name: name,
        weightNow: weightNow,
        weightGoal: weightGoal,
        height: height,
        isCoach: isCoach,
        birthday: birthday,
        carbohydratesGoal: carbohydratesGoal,
        caloriesGoal: caloriesGoal,
        proteinGoal: proteinGoal,
        fatsGoal: fatsGoal,
        sexValue: sexValue
      );
      emitter(const UserInfoState.successful());
      await Future.delayed(const Duration(seconds: 5));
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
