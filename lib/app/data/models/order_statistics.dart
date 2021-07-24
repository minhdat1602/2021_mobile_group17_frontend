import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_nhom17_2021/app/data/models/sales_statistics.dart';
import 'package:mobile_nhom17_2021/app/data/models/top_user.dart';

part 'order_statistics.g.dart';

@JsonSerializable()
class OrderStatistics {
  double max;
  double min;
  double average;
  int orderNumDay;
  double salesDay;
  double profitDay;
  int userNewDay;
  int dayNum;
  int monthNum;
  int yearNum;
  List<SalesStatistics> sales;
  List<TopUser> topUsers;

  OrderStatistics(
      {this.max,
      this.min,
      this.average,
      this.dayNum,
      this.monthNum,
      this.yearNum,
      this.sales,
      this.orderNumDay,
      this.salesDay,
      this.profitDay,
      this.userNewDay,
      this.topUsers});

  factory OrderStatistics.fromJson(Map<String, dynamic> json) =>
      _$OrderStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatisticsToJson(this);
}
