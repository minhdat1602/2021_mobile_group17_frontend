import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/inventory.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItem {
  int id;
  Inventory inventory;
  int quantity;
  CartItem({this.id, this.inventory, this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
