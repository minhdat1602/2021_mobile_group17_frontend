import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/shopping-cart_controller.dart';

class ShoppingCartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShoppingCartController>(() => ShoppingCartController());
  }
}
