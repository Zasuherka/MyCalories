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
  static String? nameEating;
  static int? eatingFoodIndex;

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
    on<AddEatingFoodEvent>(_onAddEatingFood);
    on<GetEatingFoodListEvent>(_onGetEatingFoodList);
    on<DeleteEatingFoodEvent>(_onDeleteEatingFood);
    on<GetIsFoodEvent>(_onGetIsFood);
    on<GetEatingFoodInfoEvent>(_onGetEatingFoodInfo);
    on<UpdateEatingFoodEvent>(_onUpdateEatingFood);
    on<GetAllEatingFoodListEvent>(_onGetAllEatingFoodListEvent);
  }

  Future _onGetIsFood(GetIsFoodEvent event, Emitter<EatingFoodState> emitter) async {
    nameEating = event.nameEating;
  }

  Future _onGetAllEatingFoodListEvent(GetAllEatingFoodListEvent event, Emitter<EatingFoodState> emitter) async {
    emitter(EatingFoodInitialState({
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
    ));
  }

  Future _onGetEatingFoodInfo(GetEatingFoodInfoEvent event, Emitter<EatingFoodState> emitter) async {
    eatingFoodIndex = event.index;
    nameEating = event.nameEating;
    emitter(GetEatingFoodInfoState(event.eatingFood, event.index, event.nameEating));
  }

  Future<void> _updateList(Emitter<EatingFoodState> emitter) async {
    await getEatingFoodInfoNow();
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

  Future _onGetEatingFoodList(GetEatingFoodListEvent event, Emitter<EatingFoodState> emitter) async {
    final (List<EatingFood>, String) listAndCalories = getEatingList(event.nameEating);
    await getCount();
    emitter(GetEatingFoodListState(listAndCalories.$1, event.nameEating, listAndCalories.$2, localUser!.eatingValues));
  }

  Future _onAddEatingFood(AddEatingFoodEvent event, Emitter<EatingFoodState> emitter) async {
    if(date != DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)){
      await _updateList(emitter);
      date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    try{
      final (List<EatingFood>, String) listAndCalories = addFoodEatingList(nameEating!, event.idFood, event.title, event.protein, event.fats, event.carbohydrates, event.calories, event.weight);
      await setEatingFoodInfoNow();
      await getCount();
      listAndCalories.$1.forEach((element) {print(element.toString());});
      emitter(GetEatingFoodListState(listAndCalories.$1, nameEating!, listAndCalories.$2, localUser!.eatingValues));
    }
    catch (error){
      print(error.toString());
      emitter(ErrorEatingFoodState(error.toString()));
    }
  }

  Future _onUpdateEatingFood(UpdateEatingFoodEvent event, Emitter<EatingFoodState> emitter) async {
    if(date != DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)){
      await _updateList(emitter);
      date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    try{
      final (List<EatingFood>, String) listAndCalories = await updateFoodInEatingList(
          nameEating!, eatingFoodIndex!, event.weight);
      await setEatingFoodInfoNow();
      await getCount();
      emitter(GetEatingFoodListState(listAndCalories.$1, nameEating!, listAndCalories.$2, localUser!.eatingValues));
    }
    catch (error){
      emitter(ErrorEatingFoodState(error.toString()));
    }
  }

  Future _onDeleteEatingFood(DeleteEatingFoodEvent event, Emitter<EatingFoodState> emitter) async {
    if(date != DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)){
      await _updateList(emitter);
      date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    try
    {
      final (List<EatingFood>, String) listAndCalories = deleteFoodInEatingList(nameEating!, eatingFoodIndex!);
      await setEatingFoodInfoNow();
      await getCount();
      emitter(GetEatingFoodListState(listAndCalories.$1, nameEating!, listAndCalories.$2, localUser!.eatingValues));
    }
    catch (error){
      emitter(ErrorEatingFoodState(error.toString()));
    }
  }
}
