import 'dart:convert';
import 'package:app1/bloc/authorization/authorization_bloc.dart';
import 'package:app1/bloc/registration/registration_state.dart';
import 'package:app1/objects/user.dart';
import 'package:app1/service/foodService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

AppUser? localUser;

final FirebaseAuth auth = FirebaseAuth.instance;
late bool isUserConnected;


/// Получение информации о пользователе и запись в localUser
Future<AppUser?> getAppUser() async
{
  if(await isConnected()){
    try
    {
      User? user = auth.currentUser;
      if(user == null) {
        print(1);
        return null;
      }
      await user.reload();
      user = auth.currentUser;
      final userName = await ref.child('/users/${user!.uid}/name').get();
      ///final myResults = await ref.child('/users/${user.uid}/myResults').get();
      ///final myFoods = await ref.child('foods/${user.uid}/myFoods').get(); МБ не пригодится
      _setUserInfo(AppUser(userId: user.uid, name: userName.value.toString(), email: user.email!));
      return AppUser(userId: user.uid, name: userName.value.toString(), email: user.email!);
    }
    on FirebaseAuthException catch (e)
    {
      if(e.code == 'network-request-failed'){
        return await _userIsNotConnected();
      }
    }
  }
  return await _userIsNotConnected();
}

///Проверка на подключение
Future<bool> isConnected() async {
  ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

///Получение данных о пользователе в случае если нет подключения к интернету
Future<AppUser?> _userIsNotConnected() async
{
  AppUser? userInfo = await _getUserInfo();
  if (userInfo == null)
  {
    await exitUser();
    return null;
  }
  else
  {
    return userInfo;
  }
}


///Получение данных из КЭШа
Future<AppUser?> _getUserInfo() async
{
  final prefs = await SharedPreferences.getInstance();
  final userInfo = prefs.getString('userInfo');
  if (userInfo == null){
    return null;
  }
  return AppUser.fromJson(await json.decode(userInfo));
}


///Запись данных в КЭШ
Future<void> _setUserInfo(AppUser userInfo) async
{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userInfo', json.encode({
    'name' : userInfo.name,
    'email': userInfo.email,
    'userId': userInfo.userId
  }));
}

///Авторизация пользователя
Future<AuthorizationState> authorization(String email, String password) async {
  /// Переменная отвечающая за ответ фронту

  if ((email.isEmpty) && (password.isEmpty)){
    return AuthorizationError(error: 'Не все поля заполнены');
  }

  /// Попытка зайти в профиль
  try
  {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    User? user = userCredential.user;

    if (user != null) {
      if(!user.emailVerified)
      {
        await auth.signOut();
        return AuthorizationError(error: 'Ваша учётная запись не подтверждена');
      }///Возможно будет ещё логика
      else{
        return AuthorizationSuccessful();
      }
    }
  }
  /// Ответ в случае ошибки
  on FirebaseAuthException catch (e)
  {
    print(e.toString());
    if (e.code == 'network-request-failed')
    {
      return AuthorizationError(error: 'Ошибка подключения');
    }
    if (e.code == 'user-not-found')
    {
      return AuthorizationError(error: 'Пользователь с этой почтой не найден');
    } else if (e.code == 'wrong-password')
    {
      return AuthorizationError(error: 'Неверный пароль');
    }
  }

  return AuthorizationSuccessful();
}

///Регистрацаия пользователя
Future<RegistrationState> register(String email, String name, String password1, password2) async {
  if(password1 == password2) {
    /// Попытка зарегистрироваться
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password1
      );
      User? user = userCredential.user;

      if (user!= null) {
        await _newUser(user.uid, name);
        if (!user.emailVerified)
        {
          await user.sendEmailVerification();
          await auth.signOut();
        }
      }
      return RegistrationSuccessful();
    }

    /// Обработка ошибок
    on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'weak-password') {
        return RegistrationError(error: 'Пароль ненадёжный');
      } else if (e.code == 'email-already-in-use') {
        return RegistrationError(error: 'Данная электронная почта уже используется');
      } else if (e.code == 'network-request-failed')
      {
        return RegistrationError(error: 'Ошибка подключения');
      }
    }
  }
  return RegistrationError(error: 'Пароли не совпадают');
}

///Сохранение пользователя в БД при регистрации
Future<void> _newUser(String userId, String userName) async
{
  DatabaseReference ref = FirebaseDatabase.instance.ref('/users');

  try {
    ref.child(userId).child('name').set(userName);
  }
  catch (e) {
    print("Ошибка" + e.toString());
  }
}

///Получение информации о запускаемой странице
Future<bool> getPage() async
{
  localUser = await getAppUser();
  if (localUser != null)
  {
    await getUserFoods();
    await getCount();
    return true;
  }
  else
  {
    return false;
  }
}

/// Выход юзера из профиля
Future<void> exitUser() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('foodInfo');
  await prefs.remove('userInfo');
  await prefs.remove('eatingBreakfastInfo');
  await prefs.remove('eatingLunchInfo');
  await prefs.remove('eatingDinnerInfo');
  await prefs.remove('eatingAnotherInfo');
  localUser = null;
  await auth.signOut();
}

