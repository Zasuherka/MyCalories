import 'dart:io';
import 'package:app1/models/food.dart';
import 'package:app1/models/result.dart';
import 'package:hive/hive.dart';
import '../enums/sex.dart';
import 'eating_food.dart';
part 'user.g.dart';

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
///
/// Разные конструкторы(обычный [AppUser], получение из json[AppUser.fromJson])
@HiveType(typeId: 0)
class AppUser /// Назвал не User, а AppUser чтобы не было путаницы с классом из библиотеки firebase_database.dart
{
  @HiveField(0)
  final String userId;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String email;

  @HiveField(3)
  double? weightNow;

  @HiveField(4)
  double? weightGoal;

  @HiveField(5)
  int? height;

  @HiveField(6)
  DateTime? birthday;

  @HiveField(7)
  int? age;

  @HiveField(8)
  String? urlAvatar;

  @HiveField(9)
  int? caloriesGoal;

  @HiveField(10)
  int? fatsGoal;

  @HiveField(11)
  int? carbohydratesGoal;

  @HiveField(12)
  int? proteinGoal;

  @HiveField(13)
  Sex? sex;

  ///Берём как файл с телефона
  File? avatar;

  ///Подгружаем из FireBase или из [await Hive.openBox('foodBox')]
  List<Food> myFoods = [];

  ///Подгружаем из [await Hive.openBox('eatingBox')]
  List<EatingFood> eatingBreakfast = [];

  ///Подгружаем из [await Hive.openBox('eatingBox')]
  List<EatingFood> eatingLunch = [];

  ///Подгружаем из [await Hive.openBox('eatingBox')]
  List<EatingFood> eatingDinner = [];

  ///Подгружаем из [await Hive.openBox('eatingBox')]
  List<EatingFood> eatingAnother = [];

  ///Пока не используется
  List<Result> myResults = [];

  ///Считаем с помощью [await getCount()]
  Map<String, double> eatingValues = {
    'КАЛОРИИ': 0,
    'БЕЛКИ': 0,
    'ЖИРЫ': 0,
    'УГЛЕВОДЫ': 0
  };

  ///Сам возраст не передаём, только [birthday]. От этого посчитаем возраст
  AppUser(
      {
        required this.userId,
        required this.name,
        required this.email,
        required this.weightNow,
        required this.weightGoal,
        required this.height,
        required this.birthday,
        required this.urlAvatar,
        this.caloriesGoal,
        this.fatsGoal,
        this.proteinGoal, this.carbohydratesGoal
      })
  {
    _countAge();
  }

  ///Получаем данные из json
  AppUser.fromJson(Map<String?, dynamic> json):
        name = json['name'],
        email = json['email'],
        userId = json['userId'],
        urlAvatar = json['urlAvatar'],
        ///Если вдруг придёт int, а не double
        weightNow = json['weightNow'].runtimeType == double
            ? json['weightNow']
            : double.tryParse(json['weightNow'].toString()),
        ///Если вдруг придёт int, а не double
        weightGoal = json['weightGoal'].runtimeType == double
            ? json['weightGoal']
            : double.tryParse(json['weightGoal'].toString()),
        height = json['height'],
        birthday = DateTime.tryParse(json['birthday'] ?? '') ,
        proteinGoal = int.tryParse(json['proteinGoal'] ?? ''),
        carbohydratesGoal = int.tryParse(json['carbohydratesGoal'] ?? ''),
        fatsGoal = int.tryParse(json['fatsGoal'] ?? ''),
        caloriesGoal = int.tryParse(json['caloriesGoal'] ?? ''),
        sex = getSex(json['sex'])
  {
    _countAge();
  }

  ///Превращаем в json
  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'email': email,
      'userId': userId,
      'urlAvatar': urlAvatar,
      'weightNow': weightNow,
      'weightGoal': weightGoal,
      'height': height,
      'birthday': birthday,
      "proteinGoal": proteinGoal,
      "carbohydratesGoal": carbohydratesGoal,
      "fatsGoal": fatsGoal,
      "caloriesGoal": caloriesGoal,
      "sex": sex?.sex
    };
  }

  ///Считаем количество полных лет. Юзаем только в дефолтном конструкторе
  void _countAge(){
    if(birthday != null){
      birthday = DateTime(birthday!.year,birthday!.month,birthday!.day);
      int ageCounter = DateTime.now().year - birthday!.year - 1;
      if(DateTime.now().month - birthday!.month >= 0 && DateTime.now().day - birthday!.day >= 0){
        ageCounter += 1;
      }
      age = ageCounter;
    }
    else{
      age = null;
    }
  }
}