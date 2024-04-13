import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_dto.freezed.dart';
part 'collection_dto.g.dart';

@freezed
class CollectionDto with _$CollectionDto{
  const CollectionDto._();
  const factory CollectionDto({
    required String authorEmail,
    required String lowerCaseTitle,
    required String title,
    required List<String> foodsId,
  }) = _CollectionDto;

  factory CollectionDto.fromJson(Map<String, dynamic> json) => _$CollectionDtoFromJson(json);
}