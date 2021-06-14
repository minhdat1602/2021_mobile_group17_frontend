import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/models/user.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  Product product;
  User user;
  String content;
  int rate;
  DateTime dateInit;
  Review({this.product, this.content, this.dateInit, this.rate, this.user});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
