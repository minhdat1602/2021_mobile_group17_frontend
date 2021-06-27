import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/models/order.dart';
import 'package:mobile_nhom17_2021/app/models/order_statistics.dart';
import 'package:mobile_nhom17_2021/app/services/order_api.dart';

class ListOrderController extends GetxController {
  OrderAPI orderAPI = Get.put(OrderAPI());
  var origin = <Order>[];
  var orders = Future.value(<Order>[]).obs;
  var order = Order().obs;

  var orderStatistic = Future.value(OrderStatistics()).obs;

  @override
  void onInit() {
    orders.value = orderAPI.fetchOrders();
    orderStatistic.value = orderAPI.fetchOrderStatistics();

    orders.value.then((value) => origin = value);
    super.onInit();
  }

  void getDate() async {
    List<Order> results = [];
    DateTime dateNow = DateTime.now();
    // List<Order> list;
    // await orders.value.then((value) => list = value);
    for (Order order in origin) {
      if (dateNow.difference(order.createdDate).inDays == 0) results.add(order);
    }
    orders.value = Future.value(results);
  }

  void getWeek() async {
    List<Order> results = [];
    DateTime dateNow = DateTime.now();
    // List<Order> list;
    // await orders.value.then((value) => list = value);
    for (Order order in origin) {
      if (dateNow.difference(order.createdDate).inDays <= 7) results.add(order);
    }
    orders.value = Future.value(results);
  }

  void getMonth() async {
    List<Order> results = [];
    DateTime dateNow = DateTime.now();
    // List<Order> list;
    // await orders.value.then((value) => list = value);
    for (Order order in origin) {
      if (dateNow.difference(order.createdDate).inDays <= 30)
        results.add(order);
    }
    orders.value = Future.value(results);
  }

  void getAll() async {
    // List<Order> results = [];
    // DateTime dateNow = DateTime.now();
    // // List<Order> list;
    // // await orders.value.then((value) => list = value);
    // for (Order order in origin) {
    //   if (dateNow.difference(order.createdDate).inDays <= 30)
    //     results.add(order);
    // }
    orders.value = Future.value(origin);
  }
}
