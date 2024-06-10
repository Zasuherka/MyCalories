class Food
{
  final String idFood;

  final String authorEmail;

  final String title;

  double protein;

  double fats;

  double carbohydrates;

  double calories;

  bool isThisFoodOnTheMyFoodList = true;

  bool isUserFood = false;

  Food(this.idFood, this.authorEmail, this.title, this.protein, this.fats, this.carbohydrates, this.calories);

  Food.fromJson(Map<String, dynamic> json):
        idFood = json['idFood'],
        authorEmail = json['authorEmail'],
        title = json['title'],
        protein = double.parse(json['protein'].toString()),
        fats = double.parse(json['fats'].toString()),
        carbohydrates = double.parse(json['carbohydrates'].toString()),
        calories = double.parse(json['calories'].toString());

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


  ///Если создать идентичные объекты Food то при сравнении с помощью стандартного
  ///оператора "==" будет выдавать false, поэтому переопределяем оператор "=="
  ///и геттер  "hashCode"
  @override
  bool operator ==(Object other) =>
      other is Food &&
          idFood == other.idFood &&
          title == other.title &&
          authorEmail == other.authorEmail &&
          protein == other.protein &&
          fats == other.fats &&
          carbohydrates == other.carbohydrates &&
          calories == other.calories;

  @override
  int get hashCode =>
      idFood.hashCode ^
      authorEmail.hashCode ^
      title.hashCode ^
      protein.hashCode ^
      fats.hashCode ^
      calories.hashCode ^
      carbohydrates.hashCode;
}