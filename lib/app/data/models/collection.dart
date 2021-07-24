import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection {
  int id;
  String name;
  int brandId;

  Collection({this.id, this.name, this.brandId});

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
