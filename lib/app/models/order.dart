import 'package:mobile_nhom17_2021/app/models/coupon.dart';
import 'package:mobile_nhom17_2021/app/models/order_detail.dart';
import 'package:mobile_nhom17_2021/app/models/status.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

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
  DateTime createdDate;
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
      this.orderDetails,
      this.createdDate});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
