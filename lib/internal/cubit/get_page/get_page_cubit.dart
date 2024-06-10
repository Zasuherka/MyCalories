import 'package:app1/internal/bloc/colletion/collection_bloc.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/data/repository/collection_repository.dart';
import 'package:app1/data/repository/food_repository.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_page_state.dart';
part 'get_page_cubit.freezed.dart';

class GetPageCubit extends Cubit<GetPageState> {

  final UserRepository _userRepository = UserRepository();
  final FoodRepository _foodRepository = FoodRepository();
  final CollectionRepository _collectionService = CollectionRepository();

  AppUser? localUser;

  GetPageCubit() : super(const GetPageState.initial());

  Future listenLocalUser() async {
    UserRepository.controller.stream.listen((event) async {
      if(event == null){
        localUser = event;
        emit(const GetPageState.authPage());
      }
      if(localUser == null && event != null){
        localUser = event;
        await _foodRepository.getEatingFoodInfoInFirebase(DateTime.now());
        emit(const GetPageState.firstPage());
        await _foodRepository.getUserFoods();
        await _collectionService.getUserListCollection();
      }
    });
    await _userRepository.getAppUser();
  }
}
