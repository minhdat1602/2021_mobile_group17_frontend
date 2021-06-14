import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/inventory.dart';
import 'package:mobile_nhom17_2021/models/order.dart';

part 'order_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetail {
  int id;
  Order order;
  double price;
  double discount;
  int quantity;
  Inventory inventory;
  OrderDetail(
      {this.id,
      this.order,
      this.price,
      this.discount,
      this.quantity,
      this.inventory});

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
