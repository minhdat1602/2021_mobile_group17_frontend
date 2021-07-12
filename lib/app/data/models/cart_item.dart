import 'package:mobile_nhom17_2021/app/data/models/inventory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItem {
  int id;
  Inventory inventory;
  double quantity;
  CartItem({this.id, this.inventory, this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
