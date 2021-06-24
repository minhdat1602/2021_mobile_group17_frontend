import 'package:json_annotation/json_annotation.dart';

part 'type.g.dart';

@JsonSerializable(explicitToJson: true)
class Type {
  int id;
  String name;

  Type({this.id, this.name});

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
