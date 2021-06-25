import 'package:mobile_nhom17_2021/app/models/input.dart';
import 'package:mobile_nhom17_2021/app/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'input_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class InputDetail {
  int id;
  Input input;
  int quantity;
  Product product;
  double price;
  InputDetail({this.id, this.input, this.quantity, this.price, this.product});

  factory InputDetail.fromJson(Map<String, dynamic> json) =>
      _$InputDetailFromJson(json);
  Map<String, dynamic> toJson() => _$InputDetailToJson(this);
}
