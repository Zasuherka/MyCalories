import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:intl/intl.dart';

Future<String> register(String email, String name, String password1, password2) async {
  email = normalField(email);
  password1 = normalField(password1);
  password2 = normalField(password2);
  name = normalField(name);
  String response = 'Ошибка регистрации';

  if(password1 == password2) {
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
    } on FirebaseAuthException catch (e) {
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
  DatabaseReference ref = FirebaseDatabase.instance.ref("/users");
  // Result result = Result(21);
  // String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(result.date);
  try{
    ///TODO дописать правильную запись данных при регистрации
    await ref.set({
      userId: {
        "userName": userName,
      }
    });
  }
  catch(e)
  {
    print("Ошибка" + e.toString());
  }

}