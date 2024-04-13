import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/data/repository/food_repository.dart';
import 'package:app1/domain/repository/i_food_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';
part 'food_bloc.freezed.dart';
class FoodBloc extends Bloc<FoodEvent, FoodState> {

  final IUserRepository _userRepository = UserRepository();
  final IFoodRepository _foodRepository = FoodRepository();

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


    localUser = _userRepository.localUser;
    UserRepository.controller.stream.listen((event) {
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
    final List<Food>? listFood = await _foodRepository.createFood(
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
    emitter(const FoodState.loading());
    try{
      final List<Food>? listFood = await _foodRepository.updateFood(
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
    emitter(const FoodState.loading());
    if(await _foodRepository.deleteFood(food)){
      if (localUser != null) {
        emitter(FoodState.listFood(list: localUser!.myFoods));
      }
    }
    else{
      emitter(const FoodState.error(error: 'Ошибка при удалении еды'));
    }
  }

  ///TODO убрать [localUser] от сюда
  Future _getFoodList(Emitter<FoodState> emitter) async {
    if(localUser != null){
      emitter(const FoodState.loading());
      if(localUser!.myFoods.isEmpty){
        await _foodRepository.getUserFoods();
      }
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
  Future _findFood(String searchText, Emitter<FoodState> emitter) async {
    emitter(const FoodState.loading());
    try {
      final List<Food> findFoodList = await _foodRepository.findFood(searchText);
      emitter(FoodState.findListFood(
          userListFood: findFoodList, globalListFood: const []));
      final List<Food> findGlobalFoodList = await _foodRepository.findGlobalFood(searchText);
      emitter(FoodState.findListFood(
          userListFood: findFoodList, globalListFood: findGlobalFoodList));
    } catch (error) {
      emitter(FoodState.error(error: error.toString()));
    }
  }

  ///Добавление еды из глобального поиска в список еды пользователя
  Future _addingFood(Food food, Emitter<FoodState> emitter) async {
    emitter(const FoodState.loading());
    try {
      final List<Food> listFood = await _foodRepository.addingFood(food);
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
