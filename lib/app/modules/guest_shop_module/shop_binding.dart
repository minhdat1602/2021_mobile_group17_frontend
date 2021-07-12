import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';

class ShopBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ShopController>(ShopController());
  }
}
