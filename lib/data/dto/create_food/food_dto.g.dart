// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodDtoImpl _$$FoodDtoImplFromJson(Map<String, dynamic> json) =>
    _$FoodDtoImpl(
      title: json['title'] as String,
      lowerCaseTitle: json['lowerCaseTitle'] as String,
      protein: json['protein'] as String,
      fats: json['fats'] as String,
      carbohydrates: json['carbohydrates'] as String,
      calories: json['calories'] as String,
      authorEmail: json['authorEmail'] as String,
    );

Map<String, dynamic> _$$FoodDtoImplToJson(_$FoodDtoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'lowerCaseTitle': instance.lowerCaseTitle,
      'protein': instance.protein,
      'fats': instance.fats,
      'carbohydrates': instance.carbohydrates,
      'calories': instance.calories,
      'authorEmail': instance.authorEmail,
    };
