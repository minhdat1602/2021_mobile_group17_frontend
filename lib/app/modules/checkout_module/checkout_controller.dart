import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/data/provider/checkout_api.dart';

class CheckoutController extends GetxController {
  final CheckoutAPI checkoutAPI;
  var order = Order().obs;
  CheckoutController({@required this.checkoutAPI})
      : assert(checkoutAPI != null);

  void checkout(Cart cart, User user) {
    checkoutAPI.checkout(cart, user).then((value) {
      order.value = value;
      Get.offAllNamed("/order-detail");
    });
  }
}
