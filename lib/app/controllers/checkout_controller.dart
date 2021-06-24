import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/controllers/shopping-cart_controller.dart';
import 'package:mobile_nhom17_2021/app/models/cart.dart';
import 'package:mobile_nhom17_2021/app/models/order.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:mobile_nhom17_2021/app/services/checkout_api.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class CheckoutController extends GetxController {
  final CheckoutAPI checkoutAPI = Get.put<CheckoutAPI>(CheckoutAPI());
  var order = Order().obs;
  AuthController auth = Get.put<AuthController>(AuthController());
  ShoppingCartController shoppingCart =
      Get.put<ShoppingCartController>(ShoppingCartController());

  void checkout() async {
    Cart cart = shoppingCart.cart.value;
    User user = auth.user;
    Get.rawSnackbar(
      messageText: Center(child: CircularProgressIndicator()),
      snackPosition: SnackPosition.BOTTOM,
    );
    checkoutAPI.checkout(cart, user).then((value) {
      order.value = value;
    }).whenComplete(() {
      Get.offAllNamed(Routes.ORDER_DETAIL);
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
