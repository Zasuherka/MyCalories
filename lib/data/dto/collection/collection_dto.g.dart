// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionDtoImpl _$$CollectionDtoImplFromJson(Map<String, dynamic> json) =>
    _$CollectionDtoImpl(
      authorEmail: json['authorEmail'] as String,
      lowerCaseTitle: json['lowerCaseTitle'] as String,
      title: json['title'] as String,
      foodsId:
          (json['foodsId'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$CollectionDtoImplToJson(_$CollectionDtoImpl instance) =>
    <String, dynamic>{
      'authorEmail': instance.authorEmail,
      'lowerCaseTitle': instance.lowerCaseTitle,
      'title': instance.title,
      'foodsId': instance.foodsId,
    };
