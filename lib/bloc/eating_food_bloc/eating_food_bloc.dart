import 'dart:async';
import 'package:app1/models/eating_food.dart';
import 'package:app1/models/user.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:app1/service/food_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'eating_food_event.dart';
part 'eating_food_state.dart';
part 'eating_food_bloc.freezed.dart';

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

  EatingFoodBloc() : super(const EatingFoodState.initial()) {
    on<EatingFoodEvent>((event, emit) async {
      await event.map(
          deleteEatingFood: (_) => _deleteEatingFood(emit),
          addEatingFood: (value) =>
              _addEatingFood(
                  value.idFood, value.title, value.protein,
                  value.fats, value.carbohydrates, value.calories,
                  value.weight, emit),
          updateEatingState: (_) => _updateEatingState(emit),
          updateEatingFood: (value) =>
              _updateEatingFood(value.index, value.weight, emit),
          getNameEating: (value) =>
              _getNameEating(value.nameEating, emit),
          getEatingFoodInfo: (value) =>
              _getEatingFoodInfo(
                  value.eatingFood,
                  value.index,
                  value.nameEating,
                  emit
              ));
    });
    UserService.controller.stream.listen((event) {
      localUser = event;
      _updateInfoAboutLocalUser();
    });
  }

  _updateEatingState(Emitter<EatingFoodState> emitter) async {
    emitter(const EatingFoodState.loading());

    ///Возможно это и костыль
    localUser = _userService.localUser;
    _updateInfoAboutLocalUser();

    emitter(const EatingFoodState.eatingFood());
  }

  /// Получение названия приёма пищи
  Future _getNameEating(String nameEating, Emitter<EatingFoodState> emitter) async {
    _nameEating = nameEating;
  }

  /// Информация об отдельно съеденной еде
  Future _getEatingFoodInfo(EatingFood eatingFood, int index, String nameEating, Emitter<EatingFoodState> emitter) async {
    _eatingFoodIndex = index;
    _nameEating = nameEating;
    emitter(EatingFoodState.eatingFoodInfo(
        eatingFood: eatingFood, index: index, nameEating: nameEating));
  }

  /// Добавление еды в список приёма пищи
  Future _addEatingFood(
      String idFood, 
      String title, 
      double protein, 
      double fats, 
      double carbohydrates, 
      double calories, 
      int weight, 
      Emitter<EatingFoodState> emitter) async {
    emitter(const EatingFoodState.loading());
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
          idFood,
          title,
          protein,
          fats,
          carbohydrates,
          calories,
          weight
      );
      emitter(const EatingFoodState.eatingFood());
    } catch (error) {
      print('Ошибка: ' + error.toString());
      emitter(EatingFoodState.error(error: error.toString()));
    }
  }

  /// Обновление еды в списке приёма пищи
  Future _updateEatingFood(int index, int weight, Emitter<EatingFoodState> emitter) async {
    emitter(const EatingFoodState.loading());
    if(_nameEating == null){
      return;
    }
    try {
      await _foodService.updateFoodInEatingList(
          _nameEating!, _eatingFoodIndex!, weight);
      emitter(const EatingFoodState.eatingFood());
    } catch (error) {
      emitter(EatingFoodState.error(error: error.toString()));
    }
  }

  /// Удаление еды из приёма пищи
  Future _deleteEatingFood(Emitter<EatingFoodState> emitter) async {
    emitter(const EatingFoodState.loading());
    try {
      await _foodService.deleteFoodInEatingList(_nameEating!, _eatingFoodIndex!);
      emitter(const EatingFoodState.eatingFood());
    } catch (error) {
      emitter(EatingFoodState.error(error: error.toString()));
    }
  }

  _updateInfoAboutLocalUser(){
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
  }
}
