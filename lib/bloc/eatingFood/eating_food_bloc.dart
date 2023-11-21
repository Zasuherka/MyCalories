import 'dart:async';
import 'package:app1/objects/eatingFood.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/foodService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eating_food_event.dart';
part 'eating_food_state.dart';

class EatingFoodBloc extends Bloc<EatingFoodEvent, EatingFoodState> {
  static DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  EatingFoodBloc() : super(EatingFoodInitialState({
    'Завтрак': localUser!.eatingBreakfast,
    'Обед': localUser!.eatingLunch,
    'Ужин': localUser!.eatingDinner,
    'Другое': localUser!.eatingAnother,
  },
    localUser!.eatingValues,
    {
      'Завтрак': getCalories(localUser!.eatingBreakfast),
      'Обед': getCalories(localUser!.eatingLunch),
      'Ужин': getCalories(localUser!.eatingDinner),
      'Другое': getCalories(localUser!.eatingAnother),
    },
  )) {
    on<AddEatingFoodListEvent>(_onAddEatingFoodList);
    on<GetIsFoodEvent>(_onGetIsFood);
    on<GetEatingFoodListEvent>(_onGetEatingFoodList);
  }

  Future<void> _updateList(Emitter<EatingFoodState> emitter) async {
    await setEatingFoodInfo();
    final (List<EatingFood>, String) breakfast = getEatingList('Завтрак');
    final (List<EatingFood>, String) lunch = getEatingList('Обед');
    final (List<EatingFood>, String) dinner = getEatingList('Ужин');
    final (List<EatingFood>, String) another = getEatingList('Другое');
    await getCount();
    emitter(GetEatingFoodListState(breakfast.$1, 'Завтрак', breakfast.$2, localUser!.eatingValues));
    await Future.delayed(const Duration(milliseconds: 20));
    emitter(GetEatingFoodListState(lunch.$1, 'Обед', lunch.$2, localUser!.eatingValues));
    await Future.delayed(const Duration(milliseconds: 20));
    emitter(GetEatingFoodListState(dinner.$1, 'Ужин', dinner.$2, localUser!.eatingValues));
    await Future.delayed(const Duration(milliseconds: 20));
    emitter(GetEatingFoodListState(another.$1, 'Другое', another.$2, localUser!.eatingValues));
    await Future.delayed(const Duration(milliseconds: 20));
  }

  Future<void> _onGetEatingFoodList(GetEatingFoodListEvent event, Emitter<EatingFoodState> emitter) async {
    final (List<EatingFood>, String) listAndCalories = getEatingList(event.nameEating);
    await getCount();
    emitter(GetEatingFoodListState(listAndCalories.$1, event.nameEating, listAndCalories.$2, localUser!.eatingValues));
  }

  Future<void> _onGetIsFood(GetIsFoodEvent event, Emitter<EatingFoodState> emitter) async {
    isFood = event.nameEating;
  }

  Future<void> _onAddEatingFoodList(AddEatingFoodListEvent event, Emitter<EatingFoodState> emitter) async {
    if(date != DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)){
      await _updateList(emitter);
      date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    final (List<EatingFood>, String) listAndCalories = addFoodEatingList(event.idFood, event.title, event.protein, event.fats, event.carbohydrates, event.calories, event.weight);
    await setEatingFoodInfo();
    await getCount();
    emitter(GetEatingFoodListState(listAndCalories.$1, isFood!, listAndCalories.$2, localUser!.eatingValues));
  }
}
