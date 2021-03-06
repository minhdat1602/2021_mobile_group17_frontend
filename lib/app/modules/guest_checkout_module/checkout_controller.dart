import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/order_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shopping_cart_module/shopping-cart_controller.dart';
import 'package:mobile_nhom17_2021/app/data/services/checkout_api.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class CheckoutController extends GetxController {
  final CheckoutAPI checkoutAPI = Get.put<CheckoutAPI>(CheckoutAPI());
  var order = Order().obs;
  AuthController auth = Get.put<AuthController>(AuthController());
  ShoppingCartController shoppingCart =
      Get.put<ShoppingCartController>(ShoppingCartController());
  ListOrderController listOrderController = Get.put(ListOrderController());
  final box = GetStorage();

  void checkout() async {
    Cart cart = shoppingCart.cart.value;
    UserModel user = auth.user;
    Get.dialog(Center(child: CircularProgressIndicator()));
    checkoutAPI.checkout(cart, user).then((value) {
      order.value = value;
      listOrderController.order.value = value;
    }).whenComplete(() {
      Get.back();
      // xóa giỏ hàng
      box.remove("cart");
      Cart cart = new Cart();
      cart.cartItems = [];
      shoppingCart.cart.value = cart;

      // Chuyển trang thông tin đơn hàng
      Get.offAllNamed(Routes.MY_ORDER_DETAIL);
      //Thông báo đặt hàng thành công
      Get.rawSnackbar(
        messageText: Center(
          child: Text(
            "Đặt hàng thành công !",
            style: TextStyle(color: Colors.black),
          ),
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
      );
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
