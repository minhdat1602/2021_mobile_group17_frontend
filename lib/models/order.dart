import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/coupon.dart';
import 'package:mobile_nhom17_2021/models/customer.dart';
import 'package:mobile_nhom17_2021/models/order_detail.dart';
import 'package:mobile_nhom17_2021/models/status.dart';
import 'package:mobile_nhom17_2021/models/user.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  int id;
  String code;
  double totalSellPrice;
  double totalDiscount;
  double totalMoney;
  String notes;
  Status status;
  Coupon coupon;
  User user;
  List<OrderDetail> orderDetails;
  Order(
      {this.id,
      this.code,
      this.totalSellPrice,
      this.totalDiscount,
      this.totalMoney,
      this.notes,
      this.status,
      this.coupon,
      this.user,
      this.orderDetails});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
