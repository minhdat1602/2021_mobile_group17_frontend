import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/drawer.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_transaction_mobule/list_order_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/order_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/order_statistics.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String _timeString;
  bool timer = true;

  ListOrderController listOrderController =
      Get.put(ListOrderController(), permanent: true);

  @override
  void initState() {
    timer = true;
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    timer = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(),
      body: FutureBuilder(
        future: listOrderController.orderStatistic.value,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                color: Color(0xFF212332),
                width: Get.width,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    _dashboardAndClock(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildUserNew(snapshot.data),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: _buildOrderNum(snapshot.data),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSales(snapshot.data),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: _buildProfit(snapshot.data),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Thống kê",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 15),
                          _buildStatistic(snapshot.data),
                          SizedBox(height: 15),
                          Container(
                            width: Get.width,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Em sai rồi !"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: DrawerWidget(),
    );
  }

  Widget _buildUserNew(OrderStatistics orderStatistics) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 10, top: 13, bottom: 13),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Khách hàng mới",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            "${orderStatistics.userNewDay == null ? 0 : orderStatistics.userNewDay}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildOrderNum(OrderStatistics orderStatistics) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 10, top: 13, bottom: 13),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Đơn hàng nhận",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            "${orderStatistics.orderNumDay}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSales(OrderStatistics orderStatistics) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 10, top: 13, bottom: 13),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Doanh thu",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            "${PriceUtil.toCurrency(orderStatistics.salesDay == null ? 0 : orderStatistics.salesDay)}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildProfit(OrderStatistics orderStatistics) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 10, top: 13, bottom: 13),
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Lợi nhuận",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            "${PriceUtil.toCurrency(orderStatistics.profitDay == null ? 0 : orderStatistics.profitDay)}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistic(OrderStatistics orderStatistics) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(right: 32, top: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Doanh thu 6 tháng",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 250,
            width: Get.width,
            padding: EdgeInsets.only(right: 0, top: 16, bottom: 16),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: orderStatistics.max + orderStatistics.max * 0.1,
                titlesData: LineTitles.getTitleData(orderStatistics.sales),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      orderStatistics.sales.length,
                      (index) => FlSpot((index as num).toDouble(),
                          orderStatistics.sales[index].sales),
                    ),
                    isCurved: true,
                    // barWidth: 2,
                    colors: [Colors.blue],
                    belowBarData: BarAreaData(
                      show: true,
                      colors: [
                        Colors.blue.withOpacity(0.5),
                        Colors.blue.withOpacity(0.4),
                        Colors.blue.withOpacity(0.3),
                        Colors.blue.withOpacity(0.2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _dashboardAndClock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hôm nay",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        Text(
          _timeString,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat(' hh:mm:ss dd/MM/yyyy').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (timer)
      setState(() {
        _timeString = formattedDateTime;
      });
  }
}
