import 'package:app1/enums/authorizationStatus.dart';
import 'package:app1/enums/registrationStatus.dart';
import 'package:app1/objects/user.dart';
import 'package:app1/service/foodService.dart';
import 'package:app1/service/imageService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
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
        return null;
      }
      await user.reload();
      user = auth.currentUser;

      final DatabaseReference ref = FirebaseDatabase.instance.ref();
      final DataSnapshot userData = await ref.child('/users/${user!.uid}').get();
      final String userName = userData.child('name').value.toString();
      final String urlAvatar = userData.child('urlAvatar').value.toString();
      final double? weightNow = double.tryParse(userData.child('weightNow').value.toString());
      final double? weightGoal = double.tryParse(userData.child('weightGoal').value.toString());
      final int? height = int.tryParse(userData.child('height').value.toString());
      final DateTime? birthday = DateTime.tryParse(userData.child('birthday').value.toString());
      final int? caloriesGoal = int.tryParse(userData.child('caloriesGoal').value.toString());
      final int? fatsGoal = int.tryParse(userData.child('fatsGoal').value.toString());
      final int? carbohydratesGoal = int.tryParse(userData.child('carbohydratesGoal').value.toString());
      final int? proteinGoal = int.tryParse(userData.child('proteinGoal').value.toString());
      AppUser appUser = AppUser(userId: user.uid, name: userName, email: user.email!,
          weightNow: weightNow, weightGoal: weightGoal, height: height,
          birthday: birthday, urlAvatar: urlAvatar, caloriesGoal: caloriesGoal,
          carbohydratesGoal: carbohydratesGoal, proteinGoal: proteinGoal, fatsGoal: fatsGoal);
      setUserInfo(appUser);
      return appUser;
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
  AppUser? userInfo = await getUserInfo();
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


///Получение данных из Hive
Future<AppUser?> getUserInfo() async
{
  final Box<AppUser> userBox = Hive.box('appUser');
  if(!userBox.isNotEmpty){
    return null;
  }
  final AppUser? appUser = userBox.get('appUser');
  return appUser;
}


///Запись данных в Hive
Future setUserInfo(AppUser userInfo) async
{
  final Box<AppUser> box = Hive.box<AppUser>('appUser');
  await box.put('appUser', userInfo);
}

///Авторизация пользователя
Future<AuthorizationStatus> authorization(String email, String password) async {
  /// Переменная отвечающая за ответ фронту

  if ((email.isEmpty) && (password.isEmpty)){
    return AuthorizationStatus.errorFields;
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
        return AuthorizationStatus.errorVerified;
      }///Возможно будет ещё логика
      else{
        return AuthorizationStatus.successful;
      }
    }
  }
  /// Ответ в случае ошибки
  on FirebaseAuthException catch (e)
  {
    if (e.code == 'network-request-failed')
    {
      return AuthorizationStatus.networkRequestFailed;
    }
    if (e.code == 'user-not-found')
    {
      return AuthorizationStatus.userNotFound;
    } else if (e.code == 'wrong-password')
    {
      return AuthorizationStatus.wrongPassword;
    }
    else{
      AuthorizationStatus.error;
    }
  }
  return AuthorizationStatus.successful;
}

///Регистрацаия пользователя
Future<RegistrationStatus> register(String email, String name, String password1, password2) async {
  if(password1 == password2) {
    /// Попытка зарегистрироваться
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password1
      );
      User? user = userCredential.user;

      if (user!= null) {
        await _newUser(user, name);
        if (!user.emailVerified)
        {
          await user.sendEmailVerification();
          await auth.signOut();
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
      } else if (e.code == 'network-request-failed')
      {
        return RegistrationStatus.networkRequestFailed;
      } else{
        RegistrationStatus.error;
      }
    }
  }
  return RegistrationStatus.errorPassword;
}

///Сохранение пользователя в БД при регистрации
Future<void> _newUser(User user, String name) async
{
  DatabaseReference ref = FirebaseDatabase.instance.ref('/users/${user.uid}');

  try {
    ref.set({
      "name": name,
      "email": user.email
    });
  }
  catch (e) {
    print("Ошибка" + e.toString());
  }
}


Future updateUserInfo({String? email, String? name, double? weightNow, double? weightGoal,
  int? height, DateTime? birthday, int? caloriesGoal, int? proteinGoal, int? fatsGoal, int? carbohydratesGoal}) async{
  if (localUser == null){
    throw 'localUser равен нулю';
  }
  localUser!.email = email ?? localUser!.email;
  localUser!.name = name ?? localUser!.name;
  localUser!.weightNow = weightNow ?? localUser!.weightNow;
  localUser!.weightGoal = weightGoal ?? localUser!.weightGoal;
  localUser!.height = height ?? localUser!.height;
  localUser!.birthday = birthday ?? localUser!.birthday;
  localUser!.proteinGoal = caloriesGoal ?? localUser!.proteinGoal;
  localUser!.fatsGoal = caloriesGoal ?? localUser!.fatsGoal;
  localUser!.carbohydratesGoal = caloriesGoal ?? localUser!.carbohydratesGoal;
  localUser!.caloriesGoal = caloriesGoal ?? localUser!.caloriesGoal;
  bool emailIsNew = false;
  if (email != null && email != localUser!.email) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if(user != null){
      user.updateEmail(email).then((_)
      {
        emailIsNew = true;
      }
      ).catchError((onError) {
        emailIsNew = false;
      });
    }
  }

  if (!emailIsNew && email != localUser!.email) {
    throw 'emailError';
  }
  final DatabaseReference ref = FirebaseDatabase.instance.ref('users/${localUser!.userId}');
  ref.update({
    "name": name ?? localUser!.name,
    "email": email ?? localUser!.email,
    "weightNow": localUser!.weightNow,
    "weightGoal": localUser!.weightGoal,
    "height": localUser!.height,
    "birthday": localUser!.birthday.toString(),
    "proteinGoal": localUser!.proteinGoal.toString(),
    "carbohydratesGoal": localUser!.carbohydratesGoal.toString(),
    "fatsGoal": localUser!.fatsGoal.toString(),
    "caloriesGoal": localUser!.caloriesGoal.toString(),


  }).then((_){
  }).catchError((onError){
    throw onError;
  });
}


///Получение информации о запускаемой странице
///Реализуется в этом файле, так как [localUser] напрямую влияет на действие
///приложения
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
Future exitUser() async{
  final Box<AppUser> box = Hive.box<AppUser>('appUser');
  if (box.isNotEmpty){
    box.clear();
  }
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('foodInfo');
  await prefs.remove('userInfo');
  await prefs.remove('eatingBreakfastInfo');
  await prefs.remove('eatingLunchInfo');
  await prefs.remove('eatingDinnerInfo');
  await prefs.remove('eatingAnotherInfo');
  localUser = null;
  await auth.signOut();
  await signOut();
}

