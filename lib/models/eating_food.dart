import 'package:app1/models/food.dart';
import 'package:hive/hive.dart';

part 'eating_food.g.dart';

@HiveType(typeId: 2)
class EatingFood extends Food
{
  @HiveField(9)
  late int weight;
  EatingFood(super.idFood, super.authorEmail, super.title, super.protein, super.fats, super.carbohydrates, super.calories, this.weight);

  EatingFood.fromJson(Map<String, dynamic> json):
        weight = json['weight'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'idFood': idFood,
      'authorEmail': authorEmail,
      'title': title,
      'protein': protein,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'calories': calories,
      'weight' : weight,
      'isUserFood': isUserFood.toString()
    };
  }
}