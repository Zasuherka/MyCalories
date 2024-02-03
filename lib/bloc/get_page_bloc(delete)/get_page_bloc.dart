import 'package:app1/enums/localUserStatus.dart';
import 'package:app1/models/user.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:app1/service/food_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_page_event.dart';
part 'get_page_state.dart';

class GetPageBloc extends Bloc<PageEvent, PageState> {

  final UserService _userService = UserService();
  final FoodService _foodService = FoodService();
  AppUser? localUser;
  LocalUserStatus localUserStatus = LocalUserStatus.load;

  GetPageBloc() : super(GetPageInitialState()) {
    on<AuthenticationEvent>(_onAuthentication);
  }

  Future _onAuthentication(AuthenticationEvent event, Emitter<PageState> emitter) async{
    UserService.controller.stream.listen((event) {
      if(event == null){
        localUser = null;
        //emitter(UserIsNotLogged());
        localUserStatus = LocalUserStatus.isNull;
      }
      if(localUser == null && event != null){
        //emitter(UserIsLogged());
        localUserStatus = LocalUserStatus.auth;
      }
    });
    await _userService.getAppUser();
  }
}
