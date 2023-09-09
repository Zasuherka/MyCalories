import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth =  FirebaseAuth.instance;

Future<String> register(String email, String password1, password2) async {
  email = normalField(email);
  password1 = normalField(password1);
  password2 = normalField(password2);
  String response = 'Registration error';

  if(password1 == password2) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password1
      );
      response = 'Регистрация прошла успешно';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        response = 'The account already exists for that email.';
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