import 'package:app1/objects/food.dart';

class EatingFood extends Food
{
  late int weight;
  EatingFood(super.idFood, super.title, super.protein, super.fats, super.carbohydrates, super.calories, this.weight);

  @override
  Map<String, dynamic> toJson() {
    return {
      'idFood': idFood,
      'title': title,
      'protein': protein,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'calories': calories
    };
  }

}