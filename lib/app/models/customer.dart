import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable(explicitToJson: true)
class Customer {
  int id;
  String code;
  String fullname;
  String phone;
  String address;
  int gender;
  DateTime birthday;
  Customer(
      {this.id,
      this.code,
      this.fullname,
      this.phone,
      this.address,
      this.gender,
      this.birthday});
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
