import 'dart:async';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_food_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eating_food_event.dart';
part 'eating_food_state.dart';
part 'eating_food_bloc.freezed.dart';

class EatingFoodBloc extends Bloc<EatingFoodEvent, EatingFoodState> {

  EatingFoodBloc({required IUserRepository userRepository, required IFoodRepository foodRepository})
      : _userRepository = userRepository,
        _foodRepository = foodRepository,
        super(const EatingFoodState.initial()) {
    on<EatingFoodEvent>((event, emit) async {
      await event.map(
          deleteEatingFood: (_) => _deleteEatingFood(emit),
          addEatingFood: (value) => _addEatingFood(value.idFood, value.title, value.protein,
              value.fats, value.carbohydrates, value.calories, value.weight, emit),
          updateEatingState: (_) => _updateEatingState(emit),
          updateEatingFood: (value) => _updateEatingFood(value.index, value.weight, emit),
          setNameEating: (value) => _setNameEating(value.nameEating, emit),
          getEatingFoodInfo: (value) => _getEatingFoodInfo(
                value.eatingFood,
                emit,
                value.index,
                value.nameEating,
              ));
    });
    _userRepository.controller.stream.listen((event) {
      localUser = event;
      _updateInfoAboutLocalUser();
    });
  }

  final IUserRepository _userRepository;
  final IFoodRepository _foodRepository;

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

  static String? _nameEating;
  static int? _eatingFoodIndex;
  EatingFood? food;

  _updateEatingState(Emitter<EatingFoodState> emitter) async {
    emitter(const EatingFoodState.loading());

    ///Возможно это и костыль
    localUser = _userRepository.localUser;
    _updateInfoAboutLocalUser();

    emitter(const EatingFoodState.success());
  }

  /// Сохранияем в блоке название приёма пищи
  Future<void> _setNameEating(String nameEating, Emitter<EatingFoodState> emitter) async {
    _nameEating = nameEating;
  }

  /// Информация об отдельно съеденной еде
  Future _getEatingFoodInfo(EatingFood eatingFood, Emitter<EatingFoodState> emitter, [int? index, String? nameEating]) async {
    food = eatingFood;
    if(index != null) _eatingFoodIndex = index;
    if(nameEating != null) _nameEating = nameEating;
    if(_eatingFoodIndex != null && _nameEating != null){
      emitter(EatingFoodState.eatingFoodInfo(
          eatingFood: eatingFood, index: _eatingFoodIndex!, nameEating: _nameEating!));
    }
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
      await _foodRepository.addFoodEatingList(
          _nameEating!,
          idFood,
          title,
          protein,
          fats,
          carbohydrates,
          calories,
          weight
      );
      emitter(const EatingFoodState.success());
    } catch (error) {
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
      await _foodRepository.updateFoodInEatingList(
          _nameEating!, _eatingFoodIndex!, weight);
      emitter(const EatingFoodState.success());
    } catch (error) {
      emitter(EatingFoodState.error(error: error.toString()));
    }
  }

  /// Удаление еды из приёма пищи
  Future _deleteEatingFood(Emitter<EatingFoodState> emitter) async {
    emitter(const EatingFoodState.loading());
    try {
      await _foodRepository.deleteFoodInEatingList(_nameEating!, _eatingFoodIndex!);
      emitter(const EatingFoodState.success());
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


      caloriesInBreakfast = _foodRepository.getCaloriesString(breakfast);
      caloriesInLunch = _foodRepository.getCaloriesString(lunch);
      caloriesInDinner = _foodRepository.getCaloriesString(dinner);
      caloriesInAnother = _foodRepository.getCaloriesString(another);

      allCalories = localUser!.eatingValues['КАЛОРИИ'] ?? 0;
      allProtein = localUser!.eatingValues['БЕЛКИ'] ?? 0;
      allFats = localUser!.eatingValues['ЖИРЫ'] ?? 0;
      allCarbohydrates = localUser!.eatingValues['УГЛЕВОДЫ'] ?? 0;
    }
  }
}
