// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodDtoImpl _$$FoodDtoImplFromJson(Map<String, dynamic> json) =>
    _$FoodDtoImpl(
      idFood: json['idFood'] as String,
      title: json['title'] as String,
      protein: json['protein'] as String,
      fats: json['fats'] as String,
      carbohydrates: json['carbohydrates'] as String,
      calories: json['calories'] as String,
      authorEmail: json['authorEmail'] as String,
    );

Map<String, dynamic> _$$FoodDtoImplToJson(_$FoodDtoImpl instance) =>
    <String, dynamic>{
      'idFood': instance.idFood,
      'title': instance.title,
      'protein': instance.protein,
      'fats': instance.fats,
      'carbohydrates': instance.carbohydrates,
      'calories': instance.calories,
      'authorEmail': instance.authorEmail,
    };
