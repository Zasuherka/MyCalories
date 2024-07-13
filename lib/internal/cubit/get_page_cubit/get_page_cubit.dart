import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_collection_repository.dart';
import 'package:app1/domain/repository/i_food_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_page_state.dart';
part 'get_page_cubit.freezed.dart';

class GetPageCubit extends Cubit<GetPageState> {

  final IUserRepository _userRepository;
  final IFoodRepository _foodRepository;
  final ICollectionRepository _collectionRepository;

  AppUser? localUser;

  GetPageCubit({
    required IUserRepository userRepository,
    required IFoodRepository foodRepository,
    required ICollectionRepository collectionRepository,
  })  : _userRepository = userRepository,
        _foodRepository = foodRepository,
        _collectionRepository = collectionRepository,
        super(const GetPageState.initial());

  Future listenLocalUser() async {
    _userRepository.controller.stream.listen((event) async {
      if(event == null){
        localUser = event;
        emit(const GetPageState.authPage());
      }
      if(localUser == null && event != null){
        localUser = event;
        await _foodRepository.getEatingFoodInfoInFirebase(DateTime.now());
        emit(const GetPageState.firstPage());
        await _foodRepository.getUserFoods();
        await _collectionRepository.getUserListCollection();
      }
    });
    await _userRepository.getAppUser();
  }
}
