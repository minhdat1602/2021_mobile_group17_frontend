import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/collection.dart';

part "brand.g.dart";

@JsonSerializable(explicitToJson: true)
class Brand {
  int id;
  String name;
  List<Collection> collections;

  Brand({this.id, this.name, this.collections});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  Map<String, dynamic> toJson() => _$BrandToJson(this);

  // factory Brand.fromJson(Map<String, dynamic> json) {
  //   return Brand(id: json['id'], name: json['name']);
  // }

  // Map<String, dynamic> toJson() => {
  //       'id': this.id,
  //       "name": this.name,
  //     };
}
