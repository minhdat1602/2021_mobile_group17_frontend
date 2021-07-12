import 'package:json_annotation/json_annotation.dart';

part 'supplier.g.dart';

@JsonSerializable(explicitToJson: true)
class Supplier {
  int id;
  String code;
  String name;
  String phone;
  String email;
  String address;
  String taxcode;
  Supplier(
      {this.id,
      this.code,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.taxcode});

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);
  Map<String, dynamic> toJson() => _$SupplierToJson(this);
}
