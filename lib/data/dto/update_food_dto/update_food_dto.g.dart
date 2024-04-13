// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_food_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateFoodDtoImpl _$$UpdateFoodDtoImplFromJson(Map<String, dynamic> json) =>
    _$UpdateFoodDtoImpl(
      title: json['title'] as String,
      lowerCaseTitle: json['lowerCaseTitle'] as String,
      protein: json['protein'] as String,
      fats: json['fats'] as String,
      carbohydrates: json['carbohydrates'] as String,
      calories: json['calories'] as String,
      authorEmail: json['authorEmail'] as String,
    );

Map<String, dynamic> _$$UpdateFoodDtoImplToJson(_$UpdateFoodDtoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'lowerCaseTitle': instance.lowerCaseTitle,
      'protein': instance.protein,
      'fats': instance.fats,
      'carbohydrates': instance.carbohydrates,
      'calories': instance.calories,
      'authorEmail': instance.authorEmail,
    };
