import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/drawer.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/order_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/status.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/status_controller.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:mobile_nhom17_2021/app/data/models/sales_statistics.dart';
import 'package:mobile_nhom17_2021/app/core/utils/utils.dart';

class ListOrderScreen extends StatefulWidget {
  const ListOrderScreen({Key key}) : super(key: key);

  @override
  _ListOrderScreenState createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  ListOrderController listOrderController = Get.find<ListOrderController>();
  StatusController statusController =
      Get.put(StatusController(), permanent: true);
  String filter = "Trong ngày";
  String sorted = "Tất cả";
  int _currentIndex;
  bool a = true;

  @override
  void initState() {
    _currentIndex = 0;
    a = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(),
      drawer: DrawerWidget(),
      body: Container(
        color: Color(0xFF212332),
        child: ListView(
          children: [
            Obx(() => FutureBuilder(
                future: statusController.status.value,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // _tabController = TabController(
                    //     vsync: this, length: snapshot.data.length);
                    if (a) {
                      snapshot.data
                          .insert(0, new Status(id: 0, name: "Tất cả"));
                      a = false;
                    }
                    return DefaultTabController(
                      length: snapshot.data.length,
                      initialIndex: _currentIndex,
                      child: PreferredSize(
                        preferredSize: Size.fromHeight(30.0),
                        child: Material(
                          color: Colors.grey[100],
                          child: TabBar(
                            isScrollable: true,
                            unselectedLabelColor: Colors.brown,
                            indicatorColor: Colors.indigo[600],
                            labelColor: Colors.indigo[600],
                            onTap: (index) {
                              setState(() {
                                _currentIndex = index;
                                if (index == 0)
                                  listOrderController.getOrders();
                                else
                                  listOrderController.getOrdersByStatus(
                                      snapshot.data[index].id);
                                print(_currentIndex);
                              });
                            },
                            tabs: List.generate(
                              snapshot.data.length,
                              (index) => Tab(
                                child: Text(
                                  "${snapshot.data[index].name}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error");
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
            SizedBox(height: 5),
            Obx(() => Column(
                  children: List.generate(
                    listOrderController.orders.length,
                    (index) =>
                        _buildOrderItem(listOrderController.orders[index]),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(Order order) {
    return InkWell(
      onTap: () {
        listOrderController.order.value = order;
        Get.toNamed(Routes.ADMIN_ORDER_DETAIL);
      },
      child: Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.brown,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${order.status.name}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "${DateFormat('dd-MM-yyyy kk:mm').format(order.createdDate)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 120,
                  child: Image.network(
                    "${order.orderDetails.length > 0 ? ProjectUtil.getDisplay(order.orderDetails[0].product) : 'https://assets.adidas.com/images/h_840,f_auto,q_auto:sensitive,fl_lossy,c_fill,g_auto/74f22540ef604fc6bdf6ad26009165b4_9366/Ultraboost_21_x_Parley_Shoes_White_G55650_01_standard.jpg'}",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${order.orderDetails.length > 0 ? order.orderDetails[0].product.name : ''}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${order.orderDetails.length} sản phẩm | ${PriceUtil.toCurrency(order.totalMoney)} đ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              listOrderController.order.value = order;
                              Get.toNamed(Routes.ADMIN_ORDER_DETAIL);
                            },
                            clipBehavior: Clip.none,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              primary: Colors.grey[100],
                              elevation: 0,
                            ),
                            child: Text(
                              "Xem Chi tiết",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
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
    );
  }

  // Widget _buildOrderItem(Order order) {
  //   var color;
  //   switch (order.status.id) {
  //     case 1:
  //       color = Colors.white;
  //       break;
  //     case 2:
  //       color = Colors.yellow;
  //       break;
  //     case 3:
  //       color = Colors.green;
  //       break;
  //     case 4:
  //       color = Colors.greenAccent[200];
  //       break;
  //     default:
  //       color = Colors.cyan[100];
  //   }
  //   return InkWell(
  //     onTap: () {
  //       listOrderController.order.value = order;
  //       Get.toNamed(Routes.ADMIN_ORDER_DETAIL);
  //     },
  //     child: Container(
  //       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
  //       margin: EdgeInsets.symmetric(vertical: 2),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5),
  //         color: color,
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Expanded(
  //             child: Center(
  //               child: Text(
  //                 "${DateFormat('dd-MM-yyyy kk:mm').format(order.createdDate)}",
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Center(
  //               child: Text(
  //                 "${PriceUtil.toCurrency(order.totalMoney)} đ",
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Center(
  //               child: Text(
  //                 "${order.status.name}",
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

//   Row _buildRowHead() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(
//           child: Center(
//             child: Text(
//               "Ngày",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Center(
//             child: Text(
//               "Giá",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Center(
//             child: Text(
//               "Trạng thái",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Row _buildFilter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Text(
//           "Thời gian:",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         SizedBox(width: 20),
//         DropdownButton<String>(
//           hint: Text(
//             sorted,
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           underline: Container(width: 0, height: 0),
//           items: <String>[
//             'Trong ngày',
//             'Trong tuần',
//             'Trong tháng',
//             'Tất cả',
//           ].map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: new Text(value),
//               onTap: () => setState(() {
//                 if (value == "Trong ngày") listOrderController.getDate();
//                 if (value == "Trong tuần") listOrderController.getWeek();
//                 if (value == "Trong tháng") listOrderController.getMonth();
//                 if (value == "Tất cả") listOrderController.getAll();
//                 sorted = value;
//               }),
//             );
//           }).toList(),
//           onChanged: (value) {
//             print(value);
//           },
//         ),
//       ],
//     );
//   }
// }

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