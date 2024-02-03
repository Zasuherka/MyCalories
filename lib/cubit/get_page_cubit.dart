import 'package:app1/models/user.dart';
import 'package:app1/service/food_service.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_page_state.dart';

class GetPageCubit extends Cubit<GetPageState> {

  final UserService _userService = UserService();
  final FoodService _foodService = FoodService();

  AppUser? localUser;

  GetPageCubit() : super(GetPageInitial());

  Future listenLocalUser() async {
    UserService.controller.stream.listen((event) async {
      if(event == null){
        localUser = event;
        emit(AuthPageState());
      }
      if(localUser == null && event != null){
        localUser = event;
        await _foodService.getUserFoods();
        emit(FirstPageState());
      }
    });
    await _userService.getAppUser();
  }
}
