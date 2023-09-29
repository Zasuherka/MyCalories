class Food
{
  late String idFood;
  late String title;
  late String protein;
  late String fats;
  late String carbohydrates;
  late String calories;
  Food(this.idFood,this.title, this.protein, this.fats, this.carbohydrates, this.calories);

  void createNewFood(String titleFood, double proteins, double fats, double carbohydrates, String authorId)
  {
    ///TODO реализовать запись данных в БД
  }
}