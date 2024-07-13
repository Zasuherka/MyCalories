part of 'database.dart';

class _UserData{

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AppUserDto?> getAllInfoAboutUser({String? userId}) async {
    if(userId == null){
      User? user = _auth.currentUser;
      if (user == null) {
        return null;
      }
      await user.reload();
      user = _auth.currentUser;
      userId = user!.uid;
    }

    final DataSnapshot userData =
        await _usersRef.child(userId).get();

    final Map<String, dynamic> json = Map<String, dynamic>
        .from(userData.value as Map);

    json['userId'] = userId;

    return AppUserDto.fromFirebase(json);
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
    required AppUserDto appUserDto
  }) async {
    try {
      await _usersRef.child(appUserDto.userId).update(appUserDto.toFirebase());
    }
    catch (_) {
      rethrow;
    }
  }

  ///Сохранение пользователя в БД при регистрации
  Future<void> _newUser(User user, String name) async {
    try {
      _usersRef.child(user.uid).set({"name": name, "email": user.email});
    } catch (e) {}
  }

  Future<void> logOutUser() async {
    await _auth.signOut();
  }

  Future<List<AppUserDto>> searchUser(String searchText, String userId) async{
    List<AppUserDto> userList = [];
    final Query query = _usersRef
        .orderByChild('lowerCaseName')
        .startAt(searchText.toLowerCase())
        .endAt('${searchText.toLowerCase()}\uf8ff');
    try{
      final DataSnapshot snapshot = await query.get();
      for (DataSnapshot snapshotUser in snapshot.children) {
        final Map<String, dynamic> json = Map<String, dynamic>
            .from(snapshotUser.value as Map);
        if((json['isCoach'] ?? false) && userId != json['userId']){
          json['userId'] = snapshotUser.key;
          userList.add(AppUserDto.fromFirebase(json));
        }
      }
    }
    catch(error){}
    return userList;
  }

  Future<void> cancelCoachRequest(String coachId, String userId) async{
    final appUserDto = await getAllInfoAboutUser(userId: coachId);
    if(appUserDto == null) return;
    appUserDto.wardRequests?.removeWhere((element) => element == userId);
    updateUserInfo(appUserDto: appUserDto);
  }
}