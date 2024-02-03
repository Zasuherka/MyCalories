import 'package:hive/hive.dart';

part 'food.g.dart';

@HiveType(typeId: 1)
class Food
{
  @HiveField(0)
  final String idFood;

  @HiveField(1)
  final String authorEmail;

  @HiveField(2)
  final String title;

  @HiveField(3)
  double protein;

  @HiveField(4)
  double fats;

  @HiveField(5)
  double carbohydrates;

  @HiveField(6)
  double calories;

  @HiveField(7)
  bool isThisFoodOnTheMyFoodList = true;

  @HiveField(8)
  bool isUserFood = false;

  Food(this.idFood, this.authorEmail, this.title, this.protein, this.fats, this.carbohydrates, this.calories);

  Food.fromJson(Map<String, dynamic> json):
        idFood = json['idFood'],
        authorEmail = json['authorEmail'],
        title = json['title'],
        protein = json['protein'] is int
            ? double.tryParse(json['protein'].toString())
            : json['protein'],
        fats = json['fats'] is int
            ? double.tryParse(json['fats'].toString())
            : json['fats'],
        carbohydrates = json['carbohydrates'] is int
            ? double.tryParse(json['carbohydrates'].toString())
            : json['carbohydrates'],
        calories = json['calories'] is int
            ? double.tryParse(json['calories'].toString())
            : json['calories'],
        isUserFood = bool.parse(json['isUserFood']);

  Map<String, dynamic> toJson() {
    return {
      'idFood' : idFood,
      'authorEmail' : authorEmail,
      'title': title,
      'protein': protein,
      'fats' : fats,
      'carbohydrates': carbohydrates,
      'calories': calories,
      'isUserFood': isUserFood.toString()
    };
  }
}