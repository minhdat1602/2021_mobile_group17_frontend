import 'package:mobile_nhom17_2021/app/data/models/image.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  Product product;
  UserModel user;
  String content;
  int rate;
  DateTime createdDate;
  List<ImageModel> images;
  Review(
      {this.product,
      this.content,
      this.createdDate,
      this.rate,
      this.user,
      this.images});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
