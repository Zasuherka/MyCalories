part of 'database.dart';

class _UserData{

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AppUser?> getAllInfoAboutUser() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    await user.reload();
    user = _auth.currentUser;

    final DataSnapshot userData =
        await _usersRef.child(user!.uid).get();

    final Map<String, dynamic> json = Map<String, dynamic>
        .from(userData.value as Map);

    json['userId'] = user.uid;

    return AppUser.fromJson(json);
  }

  Future<AuthorizationStatus> authorization(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await _auth.signOut();
          return AuthorizationStatus.errorVerified;
        }

        else {
          return AuthorizationStatus.successful;
        }
      } else {
        AuthorizationStatus.error;
      }
    }
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

  Future<RegistrationStatus> register(
      String email, String name, String password1, password2) async {
    try {
      ///Почта для теста
      ///https://mycalories-76e9d.firebaseapp.com/__/auth/action
      ///pautovkirill2004@mail.ru
      ///Kirill
      ///zxcvbnm
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password1
      );
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

  Future<void> updateUserInfo({
    required String userId,
    String? email,
    String? name,
    double? weightNow,
    double? weightGoal,
    int? height,
    String? birthday,
    String? caloriesGoal,
    String? proteinGoal,
    String? fatsGoal,
    String? carbohydratesGoal,
    String? sexValue
  }) async {
    try {
      _usersRef.child(userId).update({
        "name": name,
        "email": email,
        "weightNow": weightNow,
        "weightGoal": weightGoal,
        "height": height,
        "birthday": birthday,
        "proteinGoal": proteinGoal,
        "carbohydratesGoal": carbohydratesGoal,
        "fatsGoal": fatsGoal,
        "caloriesGoal": caloriesGoal,
        "sex": sexValue
      });
    }
    catch (_) {
      rethrow;
    }
  }

  ///Сохранение пользователя в БД при регистрации
  Future<void> _newUser(User user, String name) async {
    try {
      _usersRef.child(user.uid).set({"name": name, "email": user.email});
    } catch (e) {
      print("Ошибка регистрации" + e.toString());
    }
  }

  Future logOutUser() async {
    await _auth.signOut();
  }
}