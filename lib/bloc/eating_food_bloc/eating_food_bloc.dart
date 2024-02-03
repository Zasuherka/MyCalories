import 'dart:async';
import 'package:app1/models/eating_food.dart';
import 'package:app1/models/user.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:app1/service/food_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eating_food_event.dart';

part 'eating_food_state.dart';

class EatingFoodBloc extends Bloc<EatingFoodEvent, EatingFoodState> {
  final UserService _userService = UserService();
  final FoodService _foodService = FoodService();

  List<EatingFood> breakfast = [];
  List<EatingFood> lunch = [];
  List<EatingFood> dinner = [];
  List<EatingFood> another = [];

  String caloriesInBreakfast = '0';
  String caloriesInLunch = '0';
  String caloriesInDinner = '0';
  String caloriesInAnother = '0';

  double allCalories = 0;
  double allProtein = 0;
  double allFats = 0;
  double allCarbohydrates = 0;

  AppUser? localUser;

  // static DateTime _date =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  static String? _nameEating;
  static int? _eatingFoodIndex;

  EatingFoodBloc() : super(EatingFoodInitialState()) {
    on<AddEatingFoodEvent>(_onAddEatingFood);
    on<DeleteEatingFoodEvent>(_onDeleteEatingFood);
    on<GetIsFoodEvent>(_onGetIsFood);
    on<GetEatingFoodInfoEvent>(_onGetEatingFoodInfo);
    on<UpdateEatingFoodEvent>(_onUpdateEatingFood);
    UserService.controller.stream.listen((event) {
      localUser = event;
      if(localUser != null){
        breakfast = localUser!.eatingBreakfast;
        lunch = localUser!.eatingLunch;
        dinner = localUser!.eatingDinner;
        another = localUser!.eatingAnother;

        caloriesInBreakfast = _foodService.getCalories(breakfast);
        caloriesInLunch = _foodService.getCalories(lunch);
        caloriesInDinner = _foodService.getCalories(dinner);
        caloriesInAnother = _foodService.getCalories(another);

        allCalories = localUser!.eatingValues['КАЛОРИИ'] ?? 0;
        allProtein = localUser!.eatingValues['БЕЛКИ'] ?? 0;
        allFats = localUser!.eatingValues['ЖИРЫ'] ?? 0;
        allCarbohydrates = localUser!.eatingValues['УГЛЕВОДЫ'] ?? 0;
      }
    });
  }


  /// Получение названия приёма пищи
  Future _onGetIsFood(GetIsFoodEvent event, Emitter<EatingFoodState> emitter) async {
    _nameEating = event.nameEating;
  }

  ///  Информация о отдельно съеденной еде
  Future _onGetEatingFoodInfo(GetEatingFoodInfoEvent event, Emitter<EatingFoodState> emitter) async {
    _eatingFoodIndex = event.index;
    _nameEating = event.nameEating;
    emitter(GetEatingFoodInfoState(
        event.eatingFood, event.index, event.nameEating));
  }

  /// Добавление еды в список приёма пищи
  ///TODO Если наступил новый день, вернуть настройку того, чтобы обновлялись списки съеденной еды
  Future _onAddEatingFood(AddEatingFoodEvent event, Emitter<EatingFoodState> emitter) async {
    try {
      // if (_date !=
      //     DateTime(
      //         DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      //   await _updateList(emitter);
      //   _date = DateTime(
      //       DateTime.now().year, DateTime.now().month, DateTime.now().day);
      // }
      await _foodService.addFoodEatingList(
          _nameEating!,
          event.idFood,
          event.title,
          event.protein,
          event.fats,
          event.carbohydrates,
          event.calories,
          event.weight);
    } catch (error) {
      emitter(ErrorEatingFoodState(error.toString()));
    }
  }

  /// Обновление еды в списке приёма пищи
  ///TODO Если наступил новый день, вернуть настройку того, чтобы обновлялись списки съеденной еды
  Future _onUpdateEatingFood(UpdateEatingFoodEvent event, Emitter<EatingFoodState> emitter) async {
    try {
      await _foodService.updateFoodInEatingList(
          _nameEating!, _eatingFoodIndex!, event.weight);

    } catch (error) {
      emitter(ErrorEatingFoodState(error.toString()));
    }
  }

  /// Удаление еды из приёма пищи
  ///TODO Если наступил новый день, вернуть настройку того, чтобы обновлялись списки съеденной еды
  Future _onDeleteEatingFood(DeleteEatingFoodEvent event, Emitter<EatingFoodState> emitter) async {
    try {
      await _foodService.deleteFoodInEatingList(_nameEating!, _eatingFoodIndex!);
    } catch (error) {
      emitter(ErrorEatingFoodState(error.toString()));
    }
  }
}
