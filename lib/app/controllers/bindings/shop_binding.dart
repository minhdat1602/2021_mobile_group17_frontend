import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/shop_controller.dart';

class ShopBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ShopController>(ShopController());
  }
}
