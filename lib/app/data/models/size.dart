import 'package:json_annotation/json_annotation.dart';

part 'size.g.dart';

@JsonSerializable(explicitToJson: true)
class Size {
  int id;
  String size;
  Size({this.id, this.size});
  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
  Map<String, dynamic> toJson() => _$SizeToJson(this);
}
