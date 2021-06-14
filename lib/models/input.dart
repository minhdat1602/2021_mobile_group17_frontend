import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/models/supplier.dart';

part 'input.g.dart';

@JsonSerializable(explicitToJson: true)
class Input {
  int id;
  String code;
  Supplier supplier;
  DateTime date;
  String notes;
  double totalPrice;
  int totalQuantity;
  double discount;
  double payed;
  double lack;
  Input(
      {this.id,
      this.code,
      this.supplier,
      this.date,
      this.notes,
      this.totalPrice,
      this.totalQuantity,
      this.discount,
      this.payed,
      this.lack});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);
  Map<String, dynamic> toJson() => _$InputToJson(this);
}
