import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/coupon.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/models/order_statistics.dart';
import 'package:mobile_nhom17_2021/app/data/models/status.dart';
import 'package:mobile_nhom17_2021/app/data/services/order_api.dart';

class ListOrderController extends GetxController {
  OrderAPI orderAPI = Get.put(OrderAPI());

  var orders = <Order>[].obs;
  var order = Order().obs;
  var myOrders = <Order>[].obs;
  Rx<bool> loaded = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  // Lấy danh sách tất cả đơn hàng
  // Get list all order
  void getOrders() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    orders.value = await orderAPI.fetchOrders();
    Get.back();
  }

  AuthController authController = Get.find<AuthController>();
  void getOrdersByUser(int statusId) async {
    int userId = authController.user.id;
    Get.dialog(Center(child: CircularProgressIndicator()));
    myOrders.value = await orderAPI.fetchOrdersByUser(userId, statusId);
    if (Get.isDialogOpen) Get.back();
  }

  void updateStatus(Status status) async {
    order.value.status = status;
    if (Get.isDialogOpen) Get.back();
    Get.dialog(Center(child: CircularProgressIndicator()));
    order.value = await orderAPI.updateStatus(order.value);
    if (Get.isDialogOpen) Get.back();
  }

  // Lấy sách sách đơn hàng có trạng thái id là:
  // get list order by status id
  void getOrdersByStatus(int statusId) async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    orders.value = await orderAPI.fetchOrdersByStatus(statusId);
    Get.back();
  }

  // void getDate() async {
  //   List<Order> results = [];
  //   DateTime dateNow = DateTime.now();
  //   // List<Order> list;
  //   // await orders.value.then((value) => list = value);
  //   for (Order order in origin) {
  //     if (dateNow.difference(order.createdDate).inDays == 0) results.add(order);
  //   }
  //   orders.value = Future.value(results);
  // }

  // void getWeek() async {
  //   List<Order> results = [];
  //   DateTime dateNow = DateTime.now();
  //   // List<Order> list;
  //   // await orders.value.then((value) => list = value);
  //   for (Order order in origin) {
  //     if (dateNow.difference(order.createdDate).inDays <= 7) results.add(order);
  //   }
  //   orders.value = Future.value(results);
  // }

  // void getMonth() async {
  //   List<Order> results = [];
  //   DateTime dateNow = DateTime.now();
  //   // List<Order> list;
  //   // await orders.value.then((value) => list = value);
  //   for (Order order in origin) {
  //     if (dateNow.difference(order.createdDate).inDays <= 30)
  //       results.add(order);
  //   }
  //   orders.value = Future.value(results);
  // }

  // void getAll() async {
  //   // List<Order> results = [];
  //   // DateTime dateNow = DateTime.now();
  //   // // List<Order> list;
  //   // // await orders.value.then((value) => list = value);
  //   // for (Order order in origin) {
  //   //   if (dateNow.difference(order.createdDate).inDays <= 30)
  //   //     results.add(order);
  //   // }
  //   orders.value = Future.value(origin);
  // }
}
