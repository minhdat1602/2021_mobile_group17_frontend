import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/drawer.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_transactions/list_order_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

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
        padding: EdgeInsets.all(16),
        child: Obx(() => FutureBuilder<List<Order>>(
            future: listOrderController.orders.value,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    _buildFilter(),
                    Column(
                      children: [
                        _buildRowHead(),
                        SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            snapshot.data.length,
                            (index) {
                              return _buildOrderItem(snapshot.data[index]);
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
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
    );
  }

  Widget _buildOrderItem(Order order) {
    var color;
    switch (order.status.id) {
      case 1:
        color = Colors.blue;
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
