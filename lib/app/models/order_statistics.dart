import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/app/models/sales_statistics.dart';

part 'order_statistics.g.dart';

@JsonSerializable()
class OrderStatistics {
  double max;
  double min;
  double average;
  int dayNum;
  int monthNum;
  int yearNum;
  List<SalesStatistics> sales;

  OrderStatistics(
      {this.max,
      this.min,
      this.average,
      this.dayNum,
      this.monthNum,
      this.yearNum,
      this.sales});

  factory OrderStatistics.fromJson(Map<String, dynamic> json) =>
      _$OrderStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatisticsToJson(this);
}
