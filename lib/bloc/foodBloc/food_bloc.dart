import 'package:app1/objects/food.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/foodService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitialState()) {
    on<CreateFoodEvent>(_onCreateFood);
    on<UpdateFoodEvent>(_onUpdateFood);
    on<GetListFoodEvent>(_onGetFoodList);
    on<DeleteFoodEvent>(_onDeleteFood);
    on<FoodInitialEvent>(_onFoodList);
  }

  Future<void> _onCreateFood(CreateFoodEvent event, Emitter<FoodState> emitter) async{
    final Food? food = await createFood(event.title, event.protein, event.fats, event.carbohydrates, event.calories);
    if(food == null){
      emitter(ErrorFoodState());
    }
    else{
      emitter(GetFoodListState(localUser!.myFoods));
    }
  }

  Future<void> _onUpdateFood(UpdateFoodEvent event, Emitter<FoodState> emitter) async{
    final Food? food = await updateFood(event.food, event.title, event.protein, event.fats, event.carbohydrates, event.calories);
    if (food == null){
      emitter(ErrorFoodState());
    }
    else{
      emitter(GetFoodListState(localUser!.myFoods));
    }
  }

  Future<void> _onDeleteFood(DeleteFoodEvent event, Emitter<FoodState> emitter) async{
    if(await deleteFood(event.food)){
      emitter(GetFoodListState(localUser!.myFoods));
    }
    else{
      emitter(ErrorFoodState());
    }
  }

  void _onFoodList(FoodInitialEvent event, Emitter<FoodState> emitter){
    emitter(GetFoodListState(localUser!.myFoods));
  }

  Future<void> _onGetFoodList(GetListFoodEvent event, Emitter<FoodState> emitter)async{
    await getUserFoods();
    emitter(GetFoodListState(localUser!.myFoods));
  }
}
