import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/provider/order_api.dart';

class ListOrderController extends GetxController {
  OrderAPI orderAPI = Get.put(OrderAPI());
  var origin = <Order>[];
  var orders = Future.value(<Order>[]).obs;
  var order = Order().obs;

  @override
  void onInit() {
    orders.value = orderAPI.fetchOrders();
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
