enum Sex
{
  male('Мужской'),
  female('Женский');

  //W@HiveField(2)
  final String sex;

  const Sex(this.sex);

  Sex? getSex(String sex){
    if(sex == Sex.female.sex){
      return Sex.female;
    }
    if(sex == Sex.male.sex){
      return Sex.male;
    }
    return null;
  }
}

Sex? getSex(String? sex){
  if(sex == Sex.female.sex){
    return Sex.female;
  }
  if(sex == Sex.male.sex){
    return Sex.male;
  }
  return null;
}