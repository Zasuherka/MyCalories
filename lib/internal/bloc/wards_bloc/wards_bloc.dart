import 'package:app1/domain/enums/exercise_case.dart';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/domain/model/workout/exercise_cardio.dart';
import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/domain/model/workout/workout.dart';
import 'package:app1/domain/repository/I_wards_repository.dart';
import 'package:app1/domain/repository/i_food_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wards_event.dart';

part 'wards_state.dart';

part 'wards_bloc.freezed.dart';

class WardsBloc extends Bloc<WardsEvent, WardsState> {
  final IWardRepository _wardRepository;
  final IUserRepository _userRepository;
  final IFoodRepository _foodRepository;

  WardsBloc({
    required IWardRepository wardRepository,
    required IUserRepository userRepository,
    required IFoodRepository foodRepository,
  })  : _wardRepository = wardRepository,
        _userRepository = userRepository,
        _foodRepository = foodRepository,
        super(const WardsState.initial()) {
    on<WardsEvent>((event, emit) async {
      await event.map(
        getWardsListEvent: (_) async => await _getWardsList(emit),
        completedWorkoutList: (_) async => _getCompletedWorkoutList(emit),
        getWardRequestsListEvent: (_) async => await _getWardRequestsList(emit),
        updateLocalUserInfo: (_) {},
        getInfoAboutWard: (_) {},
        removeWards: (_) async => _removeWard(emit),
        setCurrentRoundSet: (value) async => _setCurrentRoundSet(
          emit,
          List.of(value.list),
          value.title,
          value.setCount,
        ),
        addNewExerciseSet: (value) async =>
            _addNewExerciseSet(emit, List.of(value.list), value.exerciseCase),
        deleteExercise: (value) async => _deleteExercise(emit, value.index),
        onReorder: (value) async => _onReorder(emit, value.oldIndex, value.newIndex),
        currentWorkoutEnd: (_) async => await _currentWorkoutEnd(emit),
        setWorkoutListExercise: (value) async =>
            _setWorkoutListExercise(emit, value.list != null ? List.of(value.list!) : null),
        setCurrentExerciseIndex: (value) async => _setCurrentExerciseIndex(emit, value.index),
        getInfoAboutFoodDiaryWard: (value) async => await _getEatingByData(emit, value.dateTime),
        replyWards: (value) async => await _replyWards(emit, value.appUser, value.reply),
      );
    });

    localUser = _userRepository.localUser;
    _userRepository.controller.stream.listen((event) {
      localUser = event;
    });
  }

  List<Workout> completedWorkoutsList = [];

  late Workout completedWorkout;

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

  List<AppUser> wardRequestsList = [];
  List<AppUser> wardsList = [];

  AppUser? selectedWard;

  AppUser? localUser;

  Workout workout = Workout(title: '', listExercise: []);

  int? currentExerciseIndex;

  void getInfoAboutWard(AppUser ward) {
    selectedWard = ward;
  }

  void setCompletedWorkout(Workout workout){
    completedWorkout = workout;

  }

  /// ///////////////////////////////// workout functional

  void _setCurrentExerciseIndex(Emitter<WardsState> emitter, int index) {
    emitter(const WardsState.loading());
    currentExerciseIndex = index;
    emitter(const WardsState.success());
  }

  void _setWorkoutListExercise(Emitter<WardsState> emitter, [List<Exercise>? list]) {
    emitter(const WardsState.loading());
    if (list != null) workout.listExercise = list;
    emitter(const WardsState.success());
  }

  Future<void> _currentWorkoutEnd(Emitter<WardsState> emitter) async {
    if(selectedWard == null) return;
    emitter(const WardsState.loading());
    await _wardRepository.sendWorkout(workout, selectedWard!);
    workout = Workout(title: '', listExercise: []);
    emitter(const WardsState.successWorkoutEnd());
  }

  void _onReorder(Emitter<WardsState> emitter, int oldIndex, int newIndex) {
    emitter(const WardsState.loading());
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = workout.listExercise.removeAt(oldIndex);
    workout.listExercise.insert(newIndex, item);
    emitter(const WardsState.success());
  }

  Future<void> _deleteExercise(Emitter<WardsState> emitter, int index) async {
    emitter(const WardsState.loading());
    workout.listExercise.removeAt(index);
    emitter(const WardsState.success());
  }

  Future<void> _addNewExerciseSet(
      Emitter<WardsState> emitter, List<Exercise> list, ExerciseCase exerciseCase) async {
    emitter(const WardsState.loading());
    final List<Exercise> newList = [];
    for (int i = 0; i < list.length; i++) {
      newList.add(list[i]);
      if (list[i].isNotValid) {
        currentExerciseIndex = i;
        emitter(WardsState.emptyValueIndex(index: i));
        return;
      }
    }
    workout.listExercise = newList;
    switch (exerciseCase) {
      case ExerciseCase.set:
        workout.listExercise.add(ExerciseSet());
      case ExerciseCase.roundSet:
        workout.listExercise.add(ExerciseRoundSet(physicalActivityList: []));
      case ExerciseCase.cardio:
        workout.listExercise.add(ExerciseCardio());
    }
    emitter(const WardsState.success());
  }

  Future<void> _setCurrentRoundSet(Emitter<WardsState> emitter, List<PhysicalActivity> list, String title, String setCount) async {
    if(currentExerciseIndex == null) return;
    emitter(const WardsState.loading());
    final ExerciseRoundSet exerciseRoundSet = workout.listExercise[currentExerciseIndex!] as ExerciseRoundSet;
    if(list.length < exerciseRoundSet.physicalActivityList.length) await Future.delayed(Duration(milliseconds: 1000));
    exerciseRoundSet.physicalActivityList = list;
    exerciseRoundSet.title = title;
    exerciseRoundSet.setCount = setCount;
    workout.listExercise[currentExerciseIndex!] = exerciseRoundSet;
    emitter(const WardsState.successUpdateExercise());
  }

  Future<void> _getCompletedWorkoutList(Emitter<WardsState> emitter) async{
    if(selectedWard == null) return;
    emitter(const WardsState.loading());
    completedWorkoutsList =  await _wardRepository.getCompletedWorkouts(selectedWard!.userId);
    emitter(const WardsState.success());
  }

  /// ///////////////////////////////// workout functional

  Future<void> _getWardRequestsList(Emitter<WardsState> emitter) async {
    emitter(const WardsState.loading());
    wardRequestsList = await _wardRepository.getWardRequestsList();
    emitter(WardsState.getWardRequestsList(wardRequestsList: wardRequestsList));
  }

  Future<void> _getWardsList(Emitter<WardsState> emitter) async {
    emitter(const WardsState.loading());
    wardsList = await _wardRepository.getWardsList();
    emitter(WardsState.getWardsList(wardsList: wardsList));
  }

  Future<void> _replyWards(Emitter<WardsState> emitter, AppUser ward, bool reply) async {
    emitter(const WardsState.loading());
    try {
      await _wardRepository.replyWard(ward, reply);
      wardRequestsList.removeWhere((element) => element.userId == ward.userId);
      emitter(const WardsState.success());
    } catch (error) {
      emitter(const WardsState.error(errorMessage: 'Не удалось отправить ответ пользователю'));
    }
  }

  Future<void> _removeWard(Emitter<WardsState> emitter) async{
    if(selectedWard == null) return;
    emitter(const WardsState.loading());
    try{
      await _wardRepository.removeWard(selectedWard!);
      wardsList.removeWhere((element) => element.userId == selectedWard!.userId);
      selectedWard = null;
      emitter(const WardsState.successRemoveWard());
    }
    catch(_){
      emitter(const WardsState.error(errorMessage: 'Не удалось удалить подопечного'));
    }
  }

  Future<void> _getEatingByData(Emitter<WardsState> emitter, DateTime dateTime) async {
    if (selectedWard == null) return;
    emitter(const WardsState.loading());
    selectedDate = dateTime;
    final response = await _foodRepository.getEatingFoodInfoInFirebase(
      dateTime,
      false,
      selectedWard!.userId,
    );
    breakfast = response.$1;
    lunch = response.$2;
    dinner = response.$3;
    another = response.$4;

    breakfastCalories = _foodRepository.getCalories(breakfast);
    lunchCalories = _foodRepository.getCalories(lunch);
    dinnerCalories = _foodRepository.getCalories(dinner);
    anotherCalories = _foodRepository.getCalories(another);

    calories = breakfastCalories + lunchCalories + dinnerCalories + anotherCalories;

    protein = _foodRepository.getProtein(breakfast) +
        _foodRepository.getProtein(lunch) +
        _foodRepository.getProtein(dinner) +
        _foodRepository.getProtein(another);

    fats = _foodRepository.getFats(breakfast) +
        _foodRepository.getFats(lunch) +
        _foodRepository.getFats(dinner) +
        _foodRepository.getFats(another);

    carbohydrates = _foodRepository.getCarbohydrates(breakfast) +
        _foodRepository.getCarbohydrates(lunch) +
        _foodRepository.getCarbohydrates(dinner) +
        _foodRepository.getCarbohydrates(another);
    emitter(const WardsState.success());
  }

  void resetWorkoutData() {
    workout = Workout(title: '', listExercise: []);
    currentExerciseIndex = null;
  }

  void resetData() {
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
  }
}
