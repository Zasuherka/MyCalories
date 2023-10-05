import 'dart:convert';
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
  var connectivityResult = await Connectivity().checkConnectivity();
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
Future<String> authorization(String email, String password) async {
  /// Переменная отвечающая за ответ фронту
  String response = 'Ошибка входа';

  if ((email.isEmpty) && (password.isEmpty)){
    return 'Не все поля заполнены';
  }

  email = normalField(email);
  password = normalField(password);
  /// Попытка зайти в профиль
  try
  {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    response = 'Вход выполнен.';
    User? user = userCredential.user;

    if (user != null) {
      if(!user.emailVerified)
      {
        response = 'Ваша учётная запись не подтверждена.';
        await auth.signOut();
      }///Возможно будет ещё логика
      else{
      }
    }
  }
  /// Ответ в случае ошибки
  on FirebaseAuthException catch (e)
  {
    if (e.code == 'network-request-failed')
    {
      response = 'Ошибка подключения';
    }
    if (e.code == 'user-not-found')
    {
      response = 'Пользователь с этой почтой не найден.';
    } else if (e.code == 'wrong-password')
    {
      response = 'Неверный пароль.';
    }
  }

  return response;
}

///Регистрацаия пользователя
Future<String> register(String email, String name, String password1, password2) async {
  email = normalField(email);
  password1 = normalField(password1);
  password2 = normalField(password2);
  name = normalField(name);
  /// Перменная отвечающая за ответ фронту
  String response = 'Ошибка регистрации';

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
      response = 'Регистрация прошла успешно!\nВам на почту отправленно письмо,\nподтвердите регистрацию.';
    }

    /// Обработка ошибок
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'Пароль ненадёжный';
      } else if (e.code == 'email-already-in-use') {
        response = 'Данная электронная почта уже используется';
      } else if (e.code == 'network-request-failed')
      {
        response = 'Ошибка подключения';
      }
    }
  }
  return response;
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
  localUser = null;
  await auth.signOut();
}


///Метод для удаления лишних пробелов в конце строки
String normalField(String field)
{
  while (field[field.length - 1] == ' ')
  {
    field = field.substring(0, field.length - 1);
  }
  return field;
}
