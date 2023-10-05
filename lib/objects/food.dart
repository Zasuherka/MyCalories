class Food
{
  late String idFood;
  late String title;
  late String protein;
  late String fats;
  late String carbohydrates;
  late String calories;
  Food(this.idFood,this.title, this.protein, this.fats, this.carbohydrates, this.calories);

  Food.fromJson(Map<String, dynamic> json):
        idFood = json['idFood'],
        title = json['title'],
        protein = json['protein'],
        fats = json['fats'],
        carbohydrates = json['carbohydrates'],
        calories = json['calories'];

  Map<String, dynamic> toJson() {
    return {
      'idFood' : idFood,
      'title': title,
      'protein': protein,
      'fats' : fats,
      'carbohydrates': carbohydrates,
      'calories': calories
    };
  }
}