import 'package:json_annotation/json_annotation.dart';
part 'coupon.g.dart';

@JsonSerializable(explicitToJson: true)
class Coupon {
  int id;
  String code;
  double discount;
  double maxDiscount;
  int maxTime;
  DateTime dateBegin;
  DateTime dateEnd;

  Coupon(
      {this.id,
      this.code,
      this.discount,
      this.maxDiscount,
      this.maxTime,
      this.dateBegin,
      this.dateEnd});

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
