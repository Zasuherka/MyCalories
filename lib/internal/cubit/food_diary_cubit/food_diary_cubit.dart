import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/repository/i_food_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'food_diary_state.dart';
part 'food_diary_cubit.freezed.dart';

class FoodDiaryCubit extends Cubit<FoodDiaryState> {
  FoodDiaryCubit({required IFoodRepository foodRepository}) :
        _foodRepository = foodRepository,
        super(const FoodDiaryState.initial());

  final IFoodRepository _foodRepository;

  List<EatingFood> breakfast = [];
  List<EatingFood> lunch = [];
  List<EatingFood> dinner = [];
  List<EatingFood> another = [];

  double calories = 0;
  double protein = 0;
  double fats = 0;
  double carbohydrates = 0;

  double breakfastCalories = 0;
  double lunchCalories = 0;
  double dinnerCalories = 0;
  double anotherCalories = 0;

  DateTime? selectedDate;

  Future<void> getEatingByData(DateTime dateTime) async{
    emit(const FoodDiaryState.loading());
    selectedDate = dateTime;
    final response = await _foodRepository.getEatingFoodInfoInFirebase(dateTime, false);
    breakfast = response.$1;
    lunch = response.$2;
    dinner = response.$3;
    another = response.$4;

    breakfastCalories = _foodRepository.getCalories(breakfast);
    lunchCalories = _foodRepository.getCalories(lunch);
    dinnerCalories = _foodRepository.getCalories(dinner);
    anotherCalories = _foodRepository.getCalories(another);

    calories = breakfastCalories + lunchCalories + dinnerCalories + anotherCalories;

    protein = _foodRepository.getProtein(breakfast) + _foodRepository.getProtein(lunch)
        + _foodRepository.getProtein(dinner) + _foodRepository.getProtein(another);

    fats = _foodRepository.getFats(breakfast) + _foodRepository.getFats(lunch)
        + _foodRepository.getFats(dinner) + _foodRepository.getFats(another);

    carbohydrates = _foodRepository.getCarbohydrates(breakfast) + _foodRepository.getCarbohydrates(lunch)
        + _foodRepository.getCarbohydrates(dinner) + _foodRepository.getCarbohydrates(another);

    emit(const FoodDiaryState.success());
  }

  void resetData(){
    breakfast = [];
     lunch = [];
     dinner = [];
     another = [];

     selectedDate = null;

     calories = 0;
     protein = 0;
     fats = 0;
     carbohydrates = 0;

     breakfastCalories = 0;
     lunchCalories = 0;
     dinnerCalories = 0;
     anotherCalories = 0;
     emit(const FoodDiaryState.initial());
  }
}
