import 'dart:async';
import 'dart:io';
import 'package:app1/domain/enums/authorization_status.dart';
import 'package:app1/domain/enums/registration_status.dart';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/model/user.dart';

abstract class IUserRepository {

  static final StreamController<AppUser?> controller =
      StreamController<AppUser?>.broadcast();


  AppUser? get localUser;

  void setFoodList(List<Food> listFood);

  Future setEatingFoodListForLocalUser((
    List<EatingFood>,
    List<EatingFood>,
    List<EatingFood>,
    List<EatingFood>
  ) eatingFoodLists);

  void setAvatar(String? urlAvatar, File? avatar);

  Future<void> getAppUser();

  void setUserInfo(AppUser? userInfo);

  Future<bool> isConnected();

  Future<AuthorizationStatus> authorization(String email, String password);

  Future<RegistrationStatus> register(
      String email, String name, String password1, password2);

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
  });

  Future<void> logOutUser();
}