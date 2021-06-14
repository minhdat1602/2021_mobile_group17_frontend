import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/models/size.dart';

part 'inventory.g.dart';

@JsonSerializable(explicitToJson: true)
class Inventory {
  int id;

  Size size;
  int quantity;
  Product product;
  Inventory({this.id, this.size, this.quantity, this.product});

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}
