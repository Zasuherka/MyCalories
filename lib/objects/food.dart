class Food
{
  final String idFood;
  final String authorEmail;
  final String title;
  final double protein;
  final double fats;
  final double carbohydrates;
  final double calories;
  bool isThisFoodOnTheMyFoodList = true;
  bool isUserFood = false;
  Food(this.idFood, this.authorEmail, this.title, this.protein, this.fats, this.carbohydrates, this.calories);

  Food.fromJson(Map<String, dynamic> json):
        idFood = json['idFood'],
        authorEmail = json['authorEmail'],
        title = json['title'],
        protein = json['protein'],
        fats = json['fats'],
        carbohydrates = json['carbohydrates'],
        calories = json['calories'],
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