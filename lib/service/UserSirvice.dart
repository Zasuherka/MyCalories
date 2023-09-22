import 'package:app1/objects/user.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import '../pages/firstPage.dart';

FirebaseAuth auth =  FirebaseAuth.instance;

class UserService
{
  late AppUser appUser;
  late String idUser;
  //User? user = FirebaseAuth.instance.currentUser;
}

// Future<String> getName() async
// {
//   final ref = FirebaseDatabase.instance.ref();
//   User user = FirebaseAuth.instance.currentUser!;
//   final snapshot = await ref.child('/users/${user.uid}/userName').get();
//   return snapshot.value.toString();
// }

Future<AppUser> getAppUser() async
{
  final ref = FirebaseDatabase.instance.ref();
  User user = FirebaseAuth.instance.currentUser!;
  final userName = await ref.child('/users/${user.uid}/name').get();
  String email = user.email!;
  final myResults = await ref.child('/users/${user.uid}/myResults').get();
  final myFoods = await ref.child('foods/${user.uid}/').get();
  return AppUser(user.uid,userName.value.toString(),email);
}

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
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    response = 'Вход выполнен.';
    User? user = userCredential.user;

    if (user != null) {
      if(!user.emailVerified)
      {
        response = 'Ваша учётная запись не подтверждена.';
        await FirebaseAuth.instance.signOut();
      }///Возможно будет ещё логика
    }
  }


  /// Ответ в случае ошибки
  on FirebaseAuthException catch (e)
  {
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
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password1
      );
      User? user = userCredential.user;

      if (user!= null) {
        newUser(user.uid, name);
        if (!user.emailVerified)
        {
          await user.sendEmailVerification();
          await FirebaseAuth.instance.signOut();
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
      }
    } catch (e) {
      print(e);
    }
  }
  return response;
}

String normalField(String field)
{
  while (field[field.length - 1] == ' ')
  {
    field = field.substring(0, field.length - 1);
  }
  return field;
}

Future<void> newUser(String userId, String userName) async
{
  FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('/users');

  try {
    ref.child(userId).child('name').set(userName);
  }
  catch (e) {
    print("Ошибка" + e.toString());
  }
}



Future<Widget> getPage() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instance;
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null)
  {
    return const FirstPage();
  }
  else
  {
    return const AuthorizationPage();
  }
}