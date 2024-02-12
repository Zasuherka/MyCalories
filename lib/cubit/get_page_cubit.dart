import 'package:app1/models/user.dart';
import 'package:app1/service/food_service.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_page_state.dart';
part 'get_page_cubit.freezed.dart';

class GetPageCubit extends Cubit<GetPageState> {

  final UserService _userService = UserService();
  final FoodService _foodService = FoodService();

  AppUser? localUser;

  GetPageCubit() : super(const GetPageState.initial());

  Future listenLocalUser() async {
    UserService.controller.stream.listen((event) async {
      if(event == null){
        localUser = event;
        emit(const GetPageState.authPage());
      }
      if(localUser == null && event != null){
        localUser = event;
        await _foodService.getEatingFoodInfoInFirebase(DateTime.now());
        await _foodService.getUserFoods();
        emit(const GetPageState.firstPage());
      }
    });
    await _userService.getAppUser();
  }
}
