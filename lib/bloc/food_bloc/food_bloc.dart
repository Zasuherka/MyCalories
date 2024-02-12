import 'package:app1/models/food.dart';
import 'package:app1/models/user.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:app1/service/food_service.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';
part 'food_bloc.freezed.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {

  final UserService _userService = UserService();
  final FoodService _foodService = FoodService();

  AppUser? localUser;

  FoodBloc() : super(const FoodState.initial()) {
    on<FoodEvent>(
        transformer: restartable(),
        (event, emit) async {
          await event.map(
              getFoodList: (_) => _getFoodList(emit),
              findFood: (value) => _findFood(value.searchText, emit),
              addingFood: (value) => _addingFood(value.food, emit),
              createFood: (value) =>
                  _createFood(
                      value.title, 
                      value.protein, 
                      value.fats,
                      value.carbohydrates,
                      value.calories,
                      emit
                  ), 
              updateFood: (value) => _updateFood(
                  value.food,
                  value.title,
                  value.protein,
                  value.fats,
                  value.carbohydrates,
                  value.calories,
                  emit
              ), 
              deleteFood: (value) => _deleteFood(value.food, emit),
              infoAboutFood: (value) => _getFoodInfo(value.food, emit)
          );
        }
    );


    localUser = _userService.localUser;
    UserService.controller.stream.listen((event) {
      localUser = event;
    });
  }


  ///Создание еды
  Future _createFood(
      String title, 
      String protein, 
      String fats, 
      String carbohydrates, 
      String calories, 
      Emitter<FoodState> emitter) async{
    final List<Food>? listFood = await _foodService.createFood(
        title, protein, fats, carbohydrates, calories);
    if(listFood == null){
      emitter(const FoodState.error(error: 'Ошибка при создании еды'));
    }
    else{
      emitter(FoodState.listFood(list: listFood));
    }
  }

  ///Обновление данных о еде
  Future _updateFood(
      Food food,
      String title,
      String protein,
      String fats,
      String carbohydrates,
      String calories, 
      Emitter<FoodState> emitter) async{
    
    try{
      final List<Food>? listFood = await _foodService.updateFood(
          food, title, protein,
          fats, carbohydrates, calories);
      if (listFood == null){
        emitter(const FoodState.error(error: 'Ошибка при обновлении еды'));
      }
      else{
        emitter(FoodState.listFood(list: listFood));
      }
    }
    catch(error){
      emitter(const FoodState.error(error: 'Ошибка при обновлении еды'));
    }
  }

  ///Удалеие еды(удаляет idFood из списка еды пользователя)
  Future _deleteFood(Food food, Emitter<FoodState> emitter) async{
    if(await _foodService.deleteFood(food)){
      if (localUser != null) {
        emitter(FoodState.listFood(list: localUser!.myFoods));
      }
    }
    else{
      emitter(const FoodState.error(error: 'Ошибка при удалении еды'));
    }
  }

  ///TODO убрать [localUser] от сюда
  _getFoodList(Emitter<FoodState> emitter) {
    if(localUser != null){
      emitter(FoodState.listFood(list: localUser!.myFoods));
    }
  }

  ///Метод для поиска еда.
  ///Первым этапом выполняется [findFood], он делает поиск еды по спису [localUser].
  ///После чего выкидывает [FindFoodListState] со списком найденной еды пользователя
  ///[findFoodList] и пустой список глобальной еды.
  ///Вторым этапом выполняется [findGlobalFood], для глобального поиска.
  ///После чего выкидывает [FindFoodListState] со списком найденной еды пользователя
  ///[findFoodList] и список глобальной еды [findGlobalFoodList].
  Future _findFood(String searchText, Emitter<FoodState> emitter)async{
    try {
      List<Food> findFoodList = await _foodService.findFood(searchText);
      emitter(FoodState.findListFood(
          userListFood: findFoodList, globalListFood: const []));
      List<Food> findGlobalFoodList = await _foodService.findGlobalFood(searchText);
      emitter(FoodState.findListFood(
          userListFood: findFoodList, globalListFood: findGlobalFoodList));
    } catch (error) {
      emitter(FoodState.error(error: error.toString()));
    }
  }

  Future _addingFood(Food food, Emitter<FoodState> emitter) async {
    try {
      final List<Food> listFood = await _foodService.addingFood(food);
      emitter(FoodState.listFood(list: listFood));
    }
    catch (error){
      emitter(FoodState.error(error: error.toString()));
    }
  }

  ///Передаёт в эвенте еду, с которой дальше будет идти работа в другом виджете
  Future _getFoodInfo(Food food, Emitter<FoodState> emitter) async {
    emitter(FoodState.getFoodInfo(food: food));
  }
}
