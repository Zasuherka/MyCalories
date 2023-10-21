class Food
{
  final String idFood;
  final String title;
  final double protein;
  final double fats;
  final double carbohydrates;
  final double calories;
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