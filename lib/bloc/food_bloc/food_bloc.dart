import 'package:app1/models/food.dart';
import 'package:app1/models/user.dart';
import 'package:app1/service/user_sirvice.dart';
import 'package:app1/service/food_service.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {

  final UserService _userService = UserService();
  final FoodService _foodService = FoodService();

  AppUser? localUser;

  FoodBloc() : super(FoodInitialState()) {
    on<CreateFoodEvent>(_onCreateFood);
    on<UpdateFoodEvent>(_onUpdateFood);
    on<GetFoodInfoEvent>(_onGetFoodInfo);
    on<DeleteFoodEvent>(_onDeleteFood);
    on<FindFoodEvent>(_onFindFood, transformer: restartable());
    on<FoodInitialEvent>(_onFoodList);
    on<AddingFoodEvent>(_addingFood);

    localUser = _userService.localUser;
    UserService.controller.stream.listen((event) {
      localUser = event;
    });
  }


  ///Создание еды
  Future _onCreateFood(CreateFoodEvent event, Emitter<FoodState> emitter) async{
    final List<Food>? listFood = await _foodService.createFood(event.title, event.protein, event.fats, event.carbohydrates, event.calories);
    if(listFood == null){
      emitter(ErrorFoodState('Ошибка при создании еды'));
    }
    else{
      emitter(GetFoodListState(listFood));
    }
  }

  ///Обновление данных о еде
  Future _onUpdateFood(UpdateFoodEvent event, Emitter<FoodState> emitter) async{
    await _foodService.updateFood(event.food, event.title, event.protein,
        event.fats, event.carbohydrates, event.calories).then((List<Food>? listFood) {
      if (listFood == null){
        emitter(ErrorFoodState('Ошибка при обновлении еды'));
      }
      else{
        emitter(GetFoodListState(listFood));
      }
    }).catchError((error){
      emitter(ErrorFoodState('Ошибка при обновлении еды'));
    });

  }

  ///Удалеие еды(удаляет idFood из списка еды пользователя)
  Future _onDeleteFood(DeleteFoodEvent event, Emitter<FoodState> emitter) async{
    if(await _foodService.deleteFood(event.food)){
      emitter(GetFoodListState(localUser!.myFoods));
    }
    else{
      emitter(ErrorFoodState('Ошибка при удалении еды'));
    }
  }

  ///TODO убрать [localUser] от сюда
  Future _onFoodList(FoodInitialEvent event, Emitter<FoodState> emitter) async{
    print(localUser);
    if(localUser != null){
      print(localUser!.myFoods);
      emitter(GetFoodListState(localUser!.myFoods));
    }
  }


  ///Метод для поиска еда.
  ///Первым этапом выполняется [findFood], он делает поиск еды по спису [localUser].
  ///После чего выкидывает [FindFoodListState] со списком найденной еды пользователя
  ///[findFoodList] и пустой список глобальной еды.
  ///Вторым этапом выполняется [findGlobalFood], для глобального поиска.
  ///После чего выкидывает [FindFoodListState] со списком найденной еды пользователя
  ///[findFoodList] и список глобальной еды [findGlobalFoodList].
  Future _onFindFood(FindFoodEvent event, Emitter<FoodState> emitter)async{
    try {
      List<Food> findFoodList = await _foodService.findFood(event.searchText);
      emitter(FindFoodListState(findFoodList,const []));
      List<Food> findGlobalFoodList = await _foodService.findGlobalFood(event.searchText);
      emitter(FindFoodListState(findFoodList,findGlobalFoodList));
    } catch (error) {
      emitter(ErrorFoodState(error.toString()));
    }
  }

  Future _addingFood(AddingFoodEvent event, Emitter<FoodState> emitter) async {
    try {
      final List<Food> listFood = await _foodService.addingFood(event.food);
      emitter(GetFoodListState(listFood));
    }
    catch (error){
      emitter(ErrorFoodState(error.toString()));
    }
  }

  Future _onGetFoodInfo(GetFoodInfoEvent event, Emitter<FoodState> emitter) async {
    emitter(GetFoodInfoState(event.food));
  }
}
