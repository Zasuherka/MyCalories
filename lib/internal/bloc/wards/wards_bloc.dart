import 'package:app1/data/dto/user_dto/user_dto.dart';
import 'package:app1/data/repository/food_repository.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/data/repository/wards_repository.dart';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_food_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wards_event.dart';

part 'wards_state.dart';

part 'wards_bloc.freezed.dart';

class WardsBloc extends Bloc<WardsEvent, WardsState> {
  final WardRepository _wardRepository = WardRepository();
  final IUserRepository _userRepository = UserRepository();

  final IFoodRepository _foodRepository = FoodRepository();

  List<EatingFood> breakfast = [];
  List<EatingFood> lunch = [];
  List<EatingFood> dinner = [];
  List<EatingFood> another = [];

  double calories = 0;
  double protein = 0;
  double fats = 0;
  double carbohydrates = 0;

  double breakfastCalories = 0;
  double lunchCalories = 0;
  double dinnerCalories = 0;
  double anotherCalories = 0;

  DateTime? selectedDate;

  List<AppUser> wardRequestsList = [];
  List<AppUser> wardsList = [];

  AppUser? selectedWard;

  AppUser? localUser;

  WardsBloc() : super(const WardsState.initial()) {
    on<WardsEvent>((event, emit) async {
      await event.map(
        getWardsListEvent: (_) => _getWardsList(emit),
        getWardRequestsListEvent: (_) async => await _getWardRequestsList(emit),
        updateLocalUserInfo: (_) {},
        getInfoAboutWard: (_) {},
        removeWards: (_) {},
        getInfoAboutFoodDiaryWard: (value) => _getEatingByData(emit, value.dateTime),
        replyWards: (value) => _replyWards(emit, value.appUser, value.reply),
      );
    });

    localUser = _userRepository.localUser;
    UserRepository.controller.stream.listen((event) {
      localUser = event;
    });
  }

  void getInfoAboutWard(AppUser ward) {
    selectedWard = ward;
  }

  Future<void> _getWardRequestsList(Emitter<WardsState> emitter) async {
    emitter(const WardsState.loading());
    wardRequestsList = await _wardRepository.getWardRequestsList();
    emitter(WardsState.getWardRequestsList(wardRequestsList: wardRequestsList));
  }

  Future<void> _getWardsList(Emitter<WardsState> emitter) async {
    emitter(const WardsState.loading());
    wardsList = await _wardRepository.getWardsList();
    emitter(WardsState.getWardsList(wardsList: wardsList));
  }

  Future<void> _replyWards(Emitter<WardsState> emitter, AppUser ward, bool reply) async {
    emitter(const WardsState.loading());
    try {
      await _wardRepository.replyWard(ward, reply);
      wardRequestsList.removeWhere((element) => element.userId == ward.userId);
      emitter(const WardsState.success());
    } catch (error) {
      emitter(const WardsState.error(errorMessage: 'Не удалось отправить ответ пользователю'));
    }
  }

  Future<void> _getEatingByData(Emitter<WardsState> emitter, DateTime dateTime) async {
    if (selectedWard == null) return;
    emitter(const WardsState.loading());
    selectedDate = dateTime;
    final response = await _foodRepository.getEatingFoodInfoInFirebase(
      dateTime,
      false,
      selectedWard!.userId,
    );
    breakfast = response.$1;
    lunch = response.$2;
    dinner = response.$3;
    another = response.$4;

    breakfastCalories = _foodRepository.getCalories(breakfast);
    lunchCalories = _foodRepository.getCalories(lunch);
    dinnerCalories = _foodRepository.getCalories(dinner);
    anotherCalories = _foodRepository.getCalories(another);

    calories = breakfastCalories + lunchCalories + dinnerCalories + anotherCalories;

    protein = _foodRepository.getProtein(breakfast) +
        _foodRepository.getProtein(lunch) +
        _foodRepository.getProtein(dinner) +
        _foodRepository.getProtein(another);

    fats = _foodRepository.getFats(breakfast) +
        _foodRepository.getFats(lunch) +
        _foodRepository.getFats(dinner) +
        _foodRepository.getFats(another);

    carbohydrates = _foodRepository.getCarbohydrates(breakfast) +
        _foodRepository.getCarbohydrates(lunch) +
        _foodRepository.getCarbohydrates(dinner) +
        _foodRepository.getCarbohydrates(another);
    emitter(const WardsState.success());
  }

  void resetData() {
    breakfast = [];
    lunch = [];
    dinner = [];
    another = [];

    selectedDate = null;


    calories = 0;
    protein = 0;
    fats = 0;
    carbohydrates = 0;

    breakfastCalories = 0;
    lunchCalories = 0;
    dinnerCalories = 0;
    anotherCalories = 0;
  }
}
