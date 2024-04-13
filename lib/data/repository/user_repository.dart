import 'dart:async';
import 'dart:io';
import 'package:app1/data/database/database.dart';
import 'package:app1/domain/enums/authorization_status.dart';
import 'package:app1/domain/enums/registration_status.dart';
import 'package:app1/domain/enums/sex.dart';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class UserRepository implements IUserRepository{

  static AppUser? _localUser;

  static final StreamController<AppUser?> controller =
      StreamController<AppUser?>.broadcast();


  late bool isUserConnected = true;

  @override
  AppUser? get localUser => _localUser;

  final Database _database = Database();

  @override
  void setFoodList(List<Food> listFood){
    if(_localUser != null){
      _localUser!.myFoods = listFood;
      controller.add(_localUser);
    }
  }

  @override
  Future setEatingFoodListForLocalUser(
      (
      List<EatingFood>,
      List<EatingFood>,
      List<EatingFood>,
      List<EatingFood>
      ) eatingFoodLists) async {
    if(_localUser != null){
      _localUser!.eatingBreakfast = eatingFoodLists.$1;
      _localUser!.eatingLunch = eatingFoodLists.$2;
      _localUser!.eatingDinner = eatingFoodLists.$3;
      _localUser!.eatingAnother = eatingFoodLists.$4;
      await _getCount();
      controller.add(_localUser);
    }
  }

  @override
  void setAvatar(String? urlAvatar, File? avatar){
    if(_localUser != null){
      _localUser!.urlAvatar = urlAvatar;
      _localUser!.avatar = avatar;
      controller.add(_localUser);
    }
  }

  ///Получение всех КБЖУ пользователя. Это необходимо для выведения информации на
  ///диаграммы
  Future _getCount() async {
    if (_localUser == null) {
      throw 'localUser равен нулю';
    }
    _localUser!.eatingValues['КАЛОРИИ'] = _caloriesCounter();
    _localUser!.eatingValues['БЕЛКИ'] = _proteinCounter();
    _localUser!.eatingValues['ЖИРЫ'] = _fatsCounter();
    _localUser!.eatingValues['УГЛЕВОДЫ'] = _carbohydratesCounter();
  }

  double _caloriesCounter() {
    if (_localUser == null) {
      throw '_localUser! равен нулю';
    }

    double counter = 0;
    for (EatingFood food in (
        _localUser!.eatingBreakfast +
        _localUser!.eatingLunch +
        _localUser!.eatingDinner +
        _localUser!.eatingAnother)) {
      counter += food.calories / 100 * food.weight;
    }
    return counter;
  }

  double _proteinCounter() {

    if (_localUser == null) {
      throw '_localUser! равен нулю';
    }

    double counter = 0;
    for (EatingFood food in (
        _localUser!.eatingBreakfast +
        _localUser!.eatingLunch +
        _localUser!.eatingDinner +
        _localUser!.eatingAnother)) {
      counter += food.protein / 100 * food.weight;
    }
    return counter;
  }

  double _fatsCounter() {

    if (_localUser == null) {
      throw '_localUser! равен нулю';
    }

    double counter = 0;
    for (EatingFood food in (
        _localUser!.eatingBreakfast +
        _localUser!.eatingLunch +
        _localUser!.eatingDinner +
        _localUser!.eatingAnother)) {
      counter += food.fats / 100 * food.weight;
    }
    return counter;
  }

  double _carbohydratesCounter() {
    if (_localUser == null) {
      throw '_localUser! равен нулю';
    }

    double counter = 0;
    for (EatingFood food in (
        _localUser!.eatingBreakfast +
        _localUser!.eatingLunch +
        _localUser!.eatingDinner +
        _localUser!.eatingAnother)) {
      counter += food.carbohydrates / 100 * food.weight;
    }
    return counter;
  }


  /// Получение информации о пользователе и запись в _localUser
  @override
  Future<void> getAppUser() async {
    if (await isConnected()) {
      try {
        _localUser = await _database.userData.getAllInfoAboutUser();
        if (_localUser == null) {
          controller.add(null);
          return;
        }
        print(_localUser);
        await _getCount();
        setUserInfo(_localUser!);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'network-request-failed') {
          // await _userIsNotConnected();
        }
      }
    }
    // await _userIsNotConnected();
  }

  ///Проверка на подключение
  @override
  Future<bool> isConnected() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }

  ///Получение данных о пользователе в случае если нет подключения к интернету
  // Future _userIsNotConnected() async {
  //   AppUser? userInfo = await getUserInfo();
  //   if (userInfo == null) {
  //     await logOutUser();
  //     return null;
  //   } else {
  //     _localUser = userInfo;
  //     controller.add(_localUser);
  //     return userInfo;
  //   }
  // }

  // ///Получение данных из Hive
  // Future<AppUser?> getUserInfo() async {
  //   final Box<AppUser> userBox = Hive.box<AppUser>('appUser');
  //   if (!userBox.isNotEmpty) {
  //     print('НУЛЯРА');
  //     return null;
  //   }
  //   final AppUser? appUser = userBox.get('appUser');
  //   print('конкретно $appUser');
  //   return appUser;
  // }


  @override
  void setUserInfo(AppUser? userInfo) {
    _localUser = userInfo;
    controller.add(userInfo);
    // final Box<AppUser> box = Hive.box<AppUser>('appUser');
    // await box.put('appUser', userInfo);
  }

  ///Авторизация пользователя
  @override
  Future<AuthorizationStatus> authorization(String email, String password) async {
    if ((email.isEmpty) || (password.isEmpty)) {
      return AuthorizationStatus.errorFields;
    }

    final status = await _database.userData.authorization(email, password);

    if(status == AuthorizationStatus.successful){
      await getAppUser();
    }

    return status;
  }

  ///Регистрацаия пользователя
  @override
  Future<RegistrationStatus> register(
      String email, String name, String password1, password2) async {
    if (email.isEmpty ||
        name.isEmpty ||
        password1.isEmpty ||
        password2.isEmpty) {
      return RegistrationStatus.errorFields;
    }
    if (password1 != password2) {
      return RegistrationStatus.errorPassword;
    }
    return _database.userData.register(email, name, password1, password2);
  }


  @override
  Future<void> updateUserInfo({
    String? email,
    String? name,
    double? weightNow,
    double? weightGoal,
    int? height,
    DateTime? birthday,
    int? caloriesGoal,
    int? proteinGoal,
    int? fatsGoal,
    int? carbohydratesGoal,
    String? sexValue
  }) async {
    if (_localUser == null) {
      throw '_localUser равен нулю';
    }
    if ((caloriesGoal != null && caloriesGoal < 10) ||
        (proteinGoal != null && proteinGoal < 10) ||
        (fatsGoal != null && fatsGoal < 10) ||
        (carbohydratesGoal != null && carbohydratesGoal < 10)) {
      throw 'Введите корректные данные';
    }
    final Sex? sex = getSex(sexValue);
    _localUser!.email = email ?? _localUser!.email;
    _localUser!.name = name ?? _localUser!.name;
    _localUser!.weightNow = weightNow ?? _localUser!.weightNow;
    _localUser!.weightGoal = weightGoal ?? _localUser!.weightGoal;
    _localUser!.height = height ?? _localUser!.height;
    _localUser!.birthday = birthday ?? _localUser!.birthday;
    _localUser!.proteinGoal = proteinGoal ?? _localUser!.proteinGoal;
    _localUser!.fatsGoal = fatsGoal ?? _localUser!.fatsGoal;
    _localUser!.carbohydratesGoal =
        carbohydratesGoal ?? _localUser!.carbohydratesGoal;
    _localUser!.caloriesGoal = caloriesGoal ?? _localUser!.caloriesGoal;
    _localUser!.sex = sex ?? _localUser!.sex;

    try{
      await _database.userData.updateUserInfo(
        userId: _localUser!.userId,
        name: name ?? _localUser!.name,
        email: email ?? _localUser!.email,
        weightNow: _localUser!.weightNow,
        weightGoal: _localUser!.weightGoal,
        height: _localUser!.height,
        birthday: _localUser!.birthday.toString(),
        proteinGoal: _localUser!.proteinGoal.toString(),
        carbohydratesGoal: _localUser!.carbohydratesGoal.toString(),
        fatsGoal: _localUser!.fatsGoal.toString(),
        caloriesGoal: _localUser!.caloriesGoal.toString(),
        sexValue: sex?.sex ?? _localUser!.sex?.sex
      );
    }
    catch (_){
      rethrow;
    }

    if(_localUser!.birthday != null){
      _localUser!.countAge();
    }
    setUserInfo(_localUser!);
  }

  /// Выход юзера из профиля
  @override
  Future<void> logOutUser() async {
    if (_localUser == null) {
      return;
    }
    await _database.userData.logOutUser();
    _localUser = null;
    controller.add(null);
  }
}