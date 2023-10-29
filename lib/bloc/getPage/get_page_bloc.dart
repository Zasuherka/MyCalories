import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/foodService.dart';
import 'package:app1/service/imageService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_page_event.dart';
part 'get_page_state.dart';

class GetPageBloc extends Bloc<PageEvent, PageState> {
  GetPageBloc() : super(GetPageInitialState()) {
    on<GetPageEvent>(_onGetPage);
  }

  Future<void> _onGetPage(GetPageEvent event, Emitter<PageState> emitter) async{
    localUser = await getAppUser();
    if(localUser == null){
      emitter(GetPageAuthState());
    }
    else{
      await getUserFoods();
      await getEatingFoodInfo();
      await getCount();
      emitter(GetPageAnotherState());
      await downloadImage();
    }
  }
}
