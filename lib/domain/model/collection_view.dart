import 'package:app1/domain/model/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_view.g.dart';

@JsonSerializable()
class CollectionView{
  final String id, title;

  CollectionView(this.id, this.title);

  factory CollectionView.fromJson(Map<String, dynamic> json) =>
      _$CollectionViewFromJson(json);

  factory CollectionView.fromCollection(Collection collection)=>
      CollectionView(collection.id, collection.title);

  Map<String, dynamic> toJson() => _$CollectionViewToJson(this);
}