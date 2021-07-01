import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/models/order.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/drawer.dart';
import 'package:mobile_nhom17_2021/app/controllers/list_order_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:mobile_nhom17_2021/app/models/sales_statistics.dart';

class ListOrderScreen extends StatefulWidget {
  const ListOrderScreen({Key key}) : super(key: key);

  @override
  _ListOrderScreenState createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  ListOrderController listOrderController = Get.find();
  String filter = "Trong ngày";
  String sorted = "Tất cả";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(),
      drawer: DrawerWidget(),
      body: Container(
        color: Color(0xFF2A2D3E),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Text(
                "Doanh thu 6 tháng gần nhất",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              FutureBuilder(
                  future: listOrderController.orderStatistic.value,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 250,
                        width: Get.width,
                        padding:
                            EdgeInsets.only(right: 32, top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: LineChart(
                          LineChartData(
                            minX: 0,
                            maxX: 5,
                            minY: 0,
                            maxY: snapshot.data.max + snapshot.data.max * 0.1,
                            titlesData:
                                LineTitles.getTitleData(snapshot.data.sales),
                            lineBarsData: [
                              LineChartBarData(
                                spots: List.generate(
                                  snapshot.data.sales.length,
                                  (index) => FlSpot((index as num).toDouble(),
                                      snapshot.data.sales[index].sales),
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
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Có gì đó sai sai !"));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              Container(
                // height: 250,
                width: Get.width,
                // color: Color(0xFF2A2D3E),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hôm nay",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: Get.width / 3,
                            height: 80,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Doanh số",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "2 M",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            width: Get.width / 3,
                            height: 80,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lợi nhuận",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "22 M",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: Get.width / 3,
                            height: 80,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Đơn hàng",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "126",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            width: Get.width / 3,
                            height: 80,
                            padding:
                                EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Với hôm qua",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.arrow_upward),
                                    Text(
                                      "22%",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "KH mới",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "25",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                // color: Color(0xFF2A2D3E),
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                height: Get.height,
                child: Obx(() => FutureBuilder<List<Order>>(
                    future: listOrderController.orders.value,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            _buildFilter(),
                            _buildRowHead(),
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: [
                                  Column(
                                    children: List.generate(
                                      snapshot.data.length,
                                      (index) {
                                        return _buildOrderItem(
                                            snapshot.data[index]);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Có gì đó sai sai"));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(Order order) {
    var color;
    switch (order.status.id) {
      case 1:
        color = Colors.white;
        break;
      case 2:
        color = Colors.yellow;
        break;
      case 3:
        color = Colors.green;
        break;
      case 4:
        color = Colors.greenAccent[200];
        break;
      default:
        color = Colors.cyan[100];
    }
    return InkWell(
      onTap: () {
        listOrderController.order.value = order;
        Get.toNamed(Routes.ADMIN_ORDER_DETAIL);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "${DateFormat('dd-MM-yyyy kk:mm').format(order.createdDate)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "${PriceUtil.toCurrency(order.totalMoney)} đ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "${order.status.name}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildRowHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Center(
            child: Text(
              "Ngày",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Giá",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Trạng thái",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Thời gian:",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 20),
        DropdownButton<String>(
          hint: Text(
            sorted,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          underline: Container(width: 0, height: 0),
          items: <String>[
            'Trong ngày',
            'Trong tuần',
            'Trong tháng',
            'Tất cả',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
              onTap: () => setState(() {
                if (value == "Trong ngày") listOrderController.getDate();
                if (value == "Trong tuần") listOrderController.getWeek();
                if (value == "Trong tháng") listOrderController.getMonth();
                if (value == "Tất cả") listOrderController.getAll();
                sorted = value;
              }),
            );
          }).toList(),
          onChanged: (value) {
            print(value);
          },
        ),
      ],
    );
  }
}

class LineTitles {
  static getTitleData(List<SalesStatistics> sales) => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
            getTitles: (value) {
              int index = value.toInt();
              return "${sales[index].month}/${sales[index].year}";
            }),
      );
}
