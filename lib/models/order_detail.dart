import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/order.dart';
import 'package:mobile_nhom17_2021/models/product.dart';

part 'order_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetail {
  int id;
  Order order;
  double price;
  double discount;
  int quantity;
  Product product;
  // Inventory inventory;
  OrderDetail(
      {this.id,
      this.order,
      this.price,
      this.discount,
      this.quantity,
      this.product});

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
