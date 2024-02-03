import 'package:hive/hive.dart';

part 'sex.g.dart';

@HiveType(typeId: 3)
enum Sex
{
  @HiveField(0)
  male('Мужской'),
  @HiveField(1)
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