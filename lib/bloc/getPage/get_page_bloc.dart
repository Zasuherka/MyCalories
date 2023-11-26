import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/foodService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_page_event.dart';
part 'get_page_state.dart';

class GetPageBloc extends Bloc<PageEvent, PageState> {
  GetPageBloc() : super(GetPageInitialState()) {
    on<AuthenticationEvent>(_onAuthentication);
  }

  Future _onAuthentication(AuthenticationEvent event, Emitter<PageState> emitter) async{
    localUser = await getAppUser();
    if(localUser == null){
      emitter(GetPageAuthState());
    }
    else{
      await getUserFoods();
      await getEatingFoodInfoNow();
      await getCount();
      emitter(GetPageAnotherState());
    }
  }
}
