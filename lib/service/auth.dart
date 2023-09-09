import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth =  FirebaseAuth.instance;

Future<String> authorization(String email, String password) async {
  String response = 'Ошибка входа';

  if ((email.isEmpty) && (password.isEmpty)){
    return 'Не все поля заполнены';
  }

  email = normalField(email);
  password = normalField(password);

  try
  {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    response = 'Вход выполнен';
  }
  on FirebaseAuthException catch (e)
  {
    if (e.code == 'user-not-found')
    {
      response = 'Юзер с этой почтой не найден';
    } else if (e.code == 'wrong-password')
    {
      response = 'Неверный пароль';
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