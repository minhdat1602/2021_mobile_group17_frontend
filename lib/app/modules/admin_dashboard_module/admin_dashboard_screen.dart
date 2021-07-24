import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/data/models/top_user.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/admin_appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/admin_menu_drawer.dart';
import 'package:mobile_nhom17_2021/app/data/models/order_statistics.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_order_module/admin_list_order_screen.dart';

import 'admin_dashboard_controller.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashBoardController dashBoardController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AdminAppBar(),
        drawer: AdminDrawer(),
        body: Obx(
          () => FutureBuilder(
            future: dashBoardController.orderStatistic,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    color: Color(0xff11101d),
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
                              _buildTopUser(snapshot.data.topUsers),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("FETCH ERROR!"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  Container _buildTopUser(List<TopUser> topUsers) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Top khách hàng",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Khách hàng",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Đơn hàng",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Tổng tiền",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: List.generate(
                topUsers.length,
                (index) => Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "${topUsers[index].user.userInfo.firstName} ${topUsers[index].user.userInfo.lastName}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            "${topUsers[index].buyNum}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "${PriceUtil.toCurrency(topUsers[index].totalPrice.toDouble())} đ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
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
                      (index) => FlSpot(
                          index.toDouble(), orderStatistics.sales[index].sales),
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
          "${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
