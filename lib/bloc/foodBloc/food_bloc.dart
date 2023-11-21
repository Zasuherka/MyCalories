import 'package:app1/objects/food.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/foodService.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitialState()) {
    on<CreateFoodEvent>(_onCreateFood);
    on<UpdateFoodEvent>(_onUpdateFood);
    //on<GetListFoodEvent>(_onGetFoodList);
    on<DeleteFoodEvent>(_onDeleteFood);
    on<FindFoodEvent>(_onFindFood, transformer: restartable());
    on<FoodInitialEvent>(_onFoodList);
    on<AddingFoodEvent>(_addingFood);
  }


  ///Создание еды
  Future<void> _onCreateFood(CreateFoodEvent event, Emitter<FoodState> emitter) async{
    final List<Food>? listFood = await createFood(event.title, event.protein, event.fats, event.carbohydrates, event.calories);
    if(listFood == null){
      emitter(ErrorFoodState('Ошибка при создании еды'));
    }
    else{
      emitter(GetFoodListState(listFood));
    }
  }

  ///Обновление данных о еде
  Future<void> _onUpdateFood(UpdateFoodEvent event, Emitter<FoodState> emitter) async{
    await updateFood(event.food, event.title, event.protein,
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
  Future<void> _onDeleteFood(DeleteFoodEvent event, Emitter<FoodState> emitter) async{
    if(await deleteFood(event.food)){
      emitter(GetFoodListState(localUser!.myFoods));
    }
    else{
      emitter(ErrorFoodState('Ошибка при удалении еды'));
    }
  }

  ///TODO убрать [localUser] от сюда
  Future _onFoodList(FoodInitialEvent event, Emitter<FoodState> emitter) async{
    emitter(GetFoodListState(localUser!.myFoods));
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
      List<Food> findFoodList = await findFood(event.searchText);
      emitter(FindFoodListState(findFoodList,const []));
      List<Food> findGlobalFoodList = await findGlobalFood(event.searchText);
      emitter(FindFoodListState(findFoodList,findGlobalFoodList));
    } catch (error) {
      emitter(ErrorFoodState(error.toString()));
    }
  }

  Future _addingFood(AddingFoodEvent event, Emitter<FoodState> emitter) async {
    try {
      final List<Food> listFood = await addingFood(event.food);
      emitter(GetFoodListState(listFood));
    }
    catch (error){
      emitter(ErrorFoodState(error.toString()));
    }
  }
  // Future<void> _onGetFoodList(GetListFoodEvent event, Emitter<FoodState> emitter)async{
  //   emitter(GetFoodListState(localUser!.myFoods));
  // }
}
