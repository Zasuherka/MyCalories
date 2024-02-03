import 'dart:async';
import 'dart:io';

import 'package:app1/enums/authorization_status.dart';
import 'package:app1/enums/registration_status.dart';
import 'package:app1/enums/sex.dart';
import 'package:app1/models/eating_food.dart';
import 'package:app1/models/food.dart';
import 'package:app1/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class UserService {

  static AppUser? _localUser;

  static final StreamController<AppUser?> controller =
      StreamController<AppUser?>.broadcast();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  late bool isUserConnected;

  AppUser? get localUser => _localUser;

  void setFoodList(List<Food> listFood){
    if(_localUser != null){
      _localUser!.myFoods = listFood;
      controller.add(_localUser);
    }
  }

  Future setEatingFoodList(
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
  Future<void> getAppUser() async {
    await Hive.openBox<AppUser>('appUser');
    if (await isConnected()) {
      try {
        User? user = _auth.currentUser;
        if (user == null) {
          controller.add(null);
          return;
        }
        await user.reload();
        user = _auth.currentUser;

        final DatabaseReference ref = FirebaseDatabase.instance.ref();
        final DataSnapshot userData =
            await ref.child('/users/${user!.uid}').get();

        Map<String, dynamic> map =
            Map<String, dynamic>.from(userData.value as Map);
        map['userId'] = user.uid;
        AppUser appUser = AppUser.fromJson(map);
        _localUser = appUser;
        await _getCount();
        await setUserInfo(appUser);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'network-request-failed') {
          await _userIsNotConnected();
        }
      }
    }
    await _userIsNotConnected();
  }

  ///Проверка на подключение
  Future<bool> isConnected() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  ///Получение данных о пользователе в случае если нет подключения к интернету
  Future _userIsNotConnected() async {
    AppUser? userInfo = await getUserInfo();
    if (userInfo == null) {
      await exitUser();
      return null;
    } else {
      _localUser = userInfo;
      controller.add(_localUser);
      return userInfo;
    }
  }

  ///Получение данных из Hive
  Future<AppUser?> getUserInfo() async {
    final Box<AppUser> userBox = Hive.box<AppUser>('appUser');
    if (!userBox.isNotEmpty) {
      return null;
    }
    final AppUser? appUser = userBox.get('appUser');
    return appUser;
  }

  ///Запись данных в Hive
  Future setUserInfo(AppUser userInfo) async {
    controller.add(userInfo);
    final Box<AppUser> box = Hive.box<AppUser>('appUser');
    await box.put('appUser', userInfo);
  }

  ///Авторизация пользователя
  Future<AuthorizationStatus> authorization(
      String email,
      String password
      ) async {
    if ((email.isEmpty) || (password.isEmpty)) {
      return AuthorizationStatus.errorFields;
    }

    /// Попытка зайти в профиль
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await _auth.signOut();
          return AuthorizationStatus.errorVerified;
        }

        ///Возможно будет ещё логика
        else {
          await getAppUser();
          return AuthorizationStatus.successful;
        }
      } else {
        AuthorizationStatus.error;
      }
    }

    /// Ответ в случае ошибки
    on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return AuthorizationStatus.networkRequestFailed;
      }
      if (e.code == 'user-not-found') {
        return AuthorizationStatus.userNotFound;
      } else if (e.code == 'wrong-password') {
        return AuthorizationStatus.wrongPassword;
      } else {
        AuthorizationStatus.error;
      }
    }
    return AuthorizationStatus.error;
  }

  ///Регистрацаия пользователя
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
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password1);
      User? user = userCredential.user;

      if (user != null) {
        await _newUser(user, name);
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          await _auth.signOut();
        }
      }
      return RegistrationStatus.successful;
    }

    /// Обработка ошибок
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return RegistrationStatus.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return RegistrationStatus.emailAlreadyInUs;
      } else if (e.code == 'network-request-failed') {
        return RegistrationStatus.networkRequestFailed;
      } else {
        return RegistrationStatus.error;
      }
    }
  }

  ///Сохранение пользователя в БД при регистрации
  Future<void> _newUser(User user, String name) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('/users/${user.uid}');
    try {
      ref.set({"name": name, "email": user.email});
    } catch (e) {
      print("Ошибка регистрации" + e.toString());
    }
  }

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
    if (email != null && email != _localUser!.email) {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        user.updateEmail(email).then((_) {}).catchError((onError) {
          email = null;
        });
      }
    }
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/${_localUser!.userId}');
    try{
      ref.update({
        "name": name ?? _localUser!.name,
        "email": email ?? _localUser!.email,
        "weightNow": _localUser!.weightNow,
        "weightGoal": _localUser!.weightGoal,
        "height": _localUser!.height,
        "birthday": _localUser!.birthday.toString(),
        "proteinGoal": _localUser!.proteinGoal.toString(),
        "carbohydratesGoal": _localUser!.carbohydratesGoal.toString(),
        "fatsGoal": _localUser!.fatsGoal.toString(),
        "caloriesGoal": _localUser!.caloriesGoal.toString(),
        "sex": sex?.sex ?? _localUser!.sex?.sex
      });
      await setUserInfo(_localUser!);
    }
    catch (_){
      rethrow;
    }
  }

  /// Выход юзера из профиля
  Future exitUser() async {
    if (_localUser == null) {
      return;
    }
    _localUser = null;
    controller.add(null);
    final Box<AppUser> box = Hive.box<AppUser>('appUser');
    if (box.isNotEmpty) {
      box.clear();
    }
    final Box<List> eatingBox = await Hive.openBox<List>('eatingBox');
    if (eatingBox.isNotEmpty) {
      eatingBox.clear();
    }
    await eatingBox.close();
    final Box<List> foodBox = await Hive.openBox<List>('foodBox');
    if (foodBox.isNotEmpty) {
      foodBox.clear();
    }
    await foodBox.close();
    await _auth.signOut();
  }
}