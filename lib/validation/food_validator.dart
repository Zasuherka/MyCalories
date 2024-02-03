mixin FoodValidationMixin {
  String foodValidator(String protein,String fats,String carbohydrates,String calories)
  {
    if (!fieldValidator(protein))
    {
      return 'Белки должны быть в диапазоне от 0.00 до 100.00';
    }
    if(!fieldValidator(fats)){
      return 'Жиры должны быть в диапазоне от 0.00 до 100.00';
    }
    if(!fieldValidator(carbohydrates)){
      return 'Углеводы должны быть в диапазоне от 0.00 до 100.00';
    }
    if (calories.isEmpty){
      return 'Поле каллории должно быть заполнено';
    }
    return '';
  }
  bool fieldValidator(String value)
  {
    final patternRegExp = RegExp(r'^\d{1,2}\.\d{0,2}$'); /// Проверка введённого в поля значения

    if (value.contains('.')){
      if (patternRegExp.hasMatch(value)){
        return true;
      }
      return false;
    }
    if (value.length == 2 || (value.length == 1 && value[0] != '0')){
      return true;
    }
    return false;
  }
}
