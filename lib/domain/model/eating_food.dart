import 'package:app1/domain/model/food.dart';

class EatingFood extends Food
{
  late int weight;
  EatingFood(super.idFood, super.authorEmail, super.title, super.protein, super.fats, super.carbohydrates, super.calories, this.weight);

  EatingFood.fromJson(super.json):
        weight = json['weight'],
        super.fromJson();

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