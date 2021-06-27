import 'package:json_annotation/json_annotation.dart';

part 'sales_statistics.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesStatistics {
  int month;
  int year;
  double sales;
  int count;

  SalesStatistics({this.month, this.year, this.sales, this.count});

  factory SalesStatistics.fromJson(Map<String, dynamic> json) =>
      _$SalesStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$SalesStatisticsToJson(this);
}
