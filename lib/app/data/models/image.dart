import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  int id;
  String url;
  int display;
  // Product product;
  ImageModel({this.id, this.url, this.display});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
