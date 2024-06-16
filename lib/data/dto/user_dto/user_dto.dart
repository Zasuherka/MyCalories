import 'dart:io';
import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/enums/sex.dart';
import 'package:app1/domain/model/user.dart';

///Класс юзера
///Вся работа с юзером происходит в UserService
/// [userId] - id Пользователя
/// [name] - имя Пользователя
/// [email] - почта Пользователя
/// [weightNow] - вес пользователя на данный момент
/// [weightGoal] - вес, к которому стремишься
/// [height] - рост
/// [birthday] - дата рождения
/// [age] - возраст(высчитывается)
/// [urlAvatar] - ссылка на аватарку
/// [avatar] - изображение аватарки. Если интернет включен качает с хранилища,
/// если нет интернета, берёт с локального хранилища
/// [myFoods] - список еды пользователя
/// [eatingBreakfast], [eatingLunch], [eatingDinner], [eatingAnother] - список
/// еды в приёмах пищи, хранится локально и обновляется при наступлении нового дня
/// [myResults] ПОКА НЕ РЕАЛИЗОВАН
/// [eatingValues] - показатели съеденных БЖУ и каллорий
///[isCoach] - тренерский аккаунт или нет
/// Разные конструкторы(обычный [AppUserDto], получение из json[AppUserDto.fromJson])
class AppUserDto /// Назвал не User, а AppUser чтобы не было путаницы с классом из библиотеки firebase_database.dart
{
  final String userId;

  late String name;

  late String email;

  bool isCoach;

  double? weightNow;

  double? weightGoal;

  int? height;

  DateTime? birthday;

  String? urlAvatar;

  int? caloriesGoal;

  int? fatsGoal;

  int? carbohydratesGoal;

  int? proteinGoal;

  String? coachId;

  String? requestCoachId;

  Sex? sex;

  List<String>? wardRequests;

  List<String>? wards;

  ///Берём как файл с телефона
  File? avatar;

  ///Подгружаем из FireBase
  List<Food> myFoods = [];

  List<String> listCollectionsId = [];

  ///Сам возраст не передаём, только [birthday]. От этого посчитаем возраст
  AppUserDto({
    required this.userId,
    required this.name,
    required this.email,
    required this.weightNow,
    required this.weightGoal,
    required this.height,
    required this.birthday,
    required this.urlAvatar,
    required this.listCollectionsId,
    this.isCoach = false,
    this.coachId,
    this.caloriesGoal,
    this.fatsGoal,
    this.proteinGoal,
    this.carbohydratesGoal,
    this.sex,
    this.requestCoachId,
    this.wards,
    this.wardRequests,
  });


  ///Получаем данные из json
  AppUserDto.fromFirebase(Map<String?, dynamic> json):
        name = json['name'],
        email = json['email'],
        userId = json['userId'],
        isCoach = json['isCoach'] ?? false,
        urlAvatar = json['urlAvatar'],
        weightNow = json['weightNow'].runtimeType == double
            ? json['weightNow']
            : double.tryParse(json['weightNow'].toString()),
        weightGoal = json['weightGoal'].runtimeType == double
            ? json['weightGoal']
            : double.tryParse(json['weightGoal'].toString()),
        height = json['height'],
        birthday = DateTime.tryParse(json['birthday'] ?? ''),
        proteinGoal = int.tryParse(json['proteinGoal'] ?? ''),
        carbohydratesGoal = int.tryParse(json['carbohydratesGoal'] ?? ''),
        fatsGoal = int.tryParse(json['fatsGoal'] ?? ''),
        caloriesGoal = int.tryParse(json['caloriesGoal'] ?? ''),
        sex = getSex(json['sex']),
        listCollectionsId = ((json['collections'] ?? []) as List)
            .map((e) => e.toString()).toList(),
        wards = (json['wards'] as List?)?.map((e) => e as String).toList(),
        wardRequests = (json['wardRequests'] as List?)?.map((e) => e as String).toList(),
        coachId = json['coachId'],
        requestCoachId = json['requestCoachId'];

  factory AppUserDto.fromAppUser(AppUser appUser){
    return AppUserDto(
        userId: appUser.userId,
        name: appUser.name,
        email: appUser.email,
        coachId: appUser.coachId,
        isCoach: appUser.isCoach,
        carbohydratesGoal: appUser.carbohydratesGoal,
        caloriesGoal: appUser.caloriesGoal,
        fatsGoal: appUser.fatsGoal,
        proteinGoal: appUser.proteinGoal,
        weightNow: appUser.weightNow,
        weightGoal: appUser.weightGoal,
        height: appUser.height,
        birthday: appUser.birthday,
        urlAvatar: appUser.urlAvatar,
        listCollectionsId: appUser.listCollectionsId,
        sex: appUser.sex,
        requestCoachId: appUser.requestCoachId,
        wardRequests: appUser.wardRequests,
        wards: appUser.wards,
    );
  }


  ///Превращаем в json
  Map<String, Object?> toFirebase() {
    return {
      'name' : name,
      'email': email,
      'isCoach': isCoach,
      'coachId': coachId,
      'urlAvatar': urlAvatar,
      'weightNow': weightNow,
      'weightGoal': weightGoal,
      'height': height,
      'birthday': birthday?.toString(),
      "proteinGoal": proteinGoal.toString(),
      "carbohydratesGoal": carbohydratesGoal.toString(),
      "fatsGoal": fatsGoal.toString(),
      "caloriesGoal": caloriesGoal.toString(),
      "sex": sex?.sex,
      "collections": listCollectionsId,
      "requestCoachId": requestCoachId,
      "wards": wards,
      "wardRequests": wardRequests,
    };
  }

  AppUser toAppUser() =>
      AppUser(
        userId: userId,
        name: name,
        isCoach: isCoach,
        coachId: coachId,
        proteinGoal: proteinGoal,
        caloriesGoal: caloriesGoal,
        carbohydratesGoal: carbohydratesGoal,
        fatsGoal: fatsGoal,
        email: email,
        weightNow: weightNow,
        weightGoal: weightGoal,
        height: height,
        sex: sex,
        birthday: birthday,
        urlAvatar: urlAvatar,
        listCollectionsId: listCollectionsId,
        requestCoachId: requestCoachId,
        wardRequests: wardRequests,
        wards: wards
      );
}