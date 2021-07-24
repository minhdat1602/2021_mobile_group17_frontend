import 'package:json_annotation/json_annotation.dart';

part 'type.g.dart';

@JsonSerializable(explicitToJson: true)
class TypeModel {
  int id;
  String name;

  TypeModel({this.id, this.name});

  factory TypeModel.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
