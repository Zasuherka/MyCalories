import 'dart:io';
import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/model/result.dart';
import 'package:app1/domain/enums/sex.dart';
import 'eating_food.dart';

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
class AppUser /// Назвал не User, а AppUser чтобы не было путаницы с классом из библиотеки firebase_database.dart
{
  final String userId;

  late String name;

  late String email;

  double? weightNow;

  double? weightGoal;

  int? height;

  DateTime? birthday;

  int? age;

  String? urlAvatar;

  int? caloriesGoal;

  int? fatsGoal;

  int? carbohydratesGoal;

  int? proteinGoal;

  Sex? sex;

  ///Берём как файл с телефона
  File? avatar;

  ///Подгружаем из FireBase
  List<Food> myFoods = [];

  ///Подгружаем из FireBase
  List<EatingFood> eatingBreakfast = [];

  ///Подгружаем из FireBase
  List<EatingFood> eatingLunch = [];

  ///Подгружаем из FireBase
  List<EatingFood> eatingDinner = [];

  ///Подгружаем из FireBase
  List<EatingFood> eatingAnother = [];

  ///Считаем с помощью [await getCount()]
  Map<String, double> eatingValues = {
    'КАЛОРИИ': 0,
    'БЕЛКИ': 0,
    'ЖИРЫ': 0,
    'УГЛЕВОДЫ': 0
  };

  List<Collection> _listCollection = [];
  List<String> listCollectionsId = [];


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
        required this.listCollectionsId,
        this.caloriesGoal,
        this.fatsGoal,
        this.proteinGoal,
        this.carbohydratesGoal,
      })
  {
    countAge();
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
        sex = getSex(json['sex']),
        listCollectionsId = (json['collections'] as List)
            .map((e) => e.toString()).toList()
  {
    countAge();
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
      "sex": sex?.sex,
      "collections": listCollectionsId
    };
  }

  ///Считаем количество полных лет. Юзаем только в дефолтном конструкторе
  void countAge(){
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

  List<Collection> get listCollection => _listCollection;

  set listCollection(List<Collection> list){
    _listCollection = list;
    listCollectionsId = list.map((e) => e.id.toString()).toList();
  }

  List<CollectionView> get listCollectionView {
    return listCollection.map((collection) => CollectionView.fromCollection(collection)).toList();
  }
}