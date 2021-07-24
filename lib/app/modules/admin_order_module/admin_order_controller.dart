import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/services/order_api.dart';

class AdminOrderController extends GetxController {
  OrderAPI orderAPI = Get.put(OrderAPI());

  var orders = <Order>[].obs;

  var _order = Order().obs;
  get order => this._order.value;
  set order(value) => this._order.value = value;

  var _loaded = false.obs;
  get loaded => this._loaded.value;

  @override
  void onInit() {
    super.onInit();
    initValue();
  }

  initValue() async {
    orders.value = await orderAPI.fetchOrders().whenComplete(() {
      _loaded.value = true;
    });
  }

  Future getOrderByStatus(int statusId) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    orders.value = statusId == 0
        ? await orderAPI.fetchOrders()
        : await orderAPI.fetchOrdersByStatus(statusId);
    if (Get.isDialogOpen) Get.back();
  }
}
