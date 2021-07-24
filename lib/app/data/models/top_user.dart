import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';

@JsonSerializable()
class TopUser {
  UserModel user;
  int totalPrice;
  int buyNum;
  TopUser({this.user, this.totalPrice, this.buyNum});

  factory TopUser.fromJson(Map<String, dynamic> json) {
    return TopUser()
      ..buyNum = json['buyNum'] == null ? 0 : json['buyNum']
      ..totalPrice = json['totalPrice'] == null ? 0 : json['totalPrice']
      ..user = json['user'] == null ? null : UserModel.fromJson(json['user']);
  }
  Map<String, dynamic> toJson() => {
        'user': this.user.toJson(),
        'totalPrice': this.totalPrice,
        'buyNum': this.buyNum,
      };
}
