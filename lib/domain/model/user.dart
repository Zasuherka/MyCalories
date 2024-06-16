import 'dart:io';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/food.dart';
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

  bool isCoach;

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

  String? coachId;

  String? requestCoachId;

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

  List<String> wardRequests = [];

  List<String> wards = [];

  ///Считаем с помощью [await getCount()]
  Map<String, double> eatingValues = {
    'КАЛОРИИ': 0,
    'БЕЛКИ': 0,
    'ЖИРЫ': 0,
    'УГЛЕВОДЫ': 0
  };

  List<CollectionView> _listCollectionView = [];
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
        this.isCoach = false,
        this.coachId,
        this.caloriesGoal,
        this.fatsGoal,
        this.proteinGoal,
        this.carbohydratesGoal,
        this.sex,
        this.requestCoachId,
        List<String>? wardRequests,
        List<String>? wards,
      })
  {
    if(wardRequests != null) this.wardRequests = wardRequests;
    if(wards != null) this.wards = wards;
    countAge();
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

  List<CollectionView> get listCollectionView => _listCollectionView;

  set listCollection(List<CollectionView> list){
    _listCollectionView = list;
    listCollectionsId = list.map((e) => e.id.toString()).toList();
  }

  // List<CollectionView> get listCollectionView {
  //   return listCollection.map((collection) => CollectionView.fromCollection(collection)).toList();
  // }
}