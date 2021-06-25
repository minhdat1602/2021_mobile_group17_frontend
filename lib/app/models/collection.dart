import 'package:mobile_nhom17_2021/app/models/brand.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection {
  int id;
  String name;
  Brand brand;

  Collection({this.id, this.name, this.brand});

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
