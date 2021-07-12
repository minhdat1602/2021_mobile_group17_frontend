import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_whishlist_module/whishlist_controller.dart';

class WhishListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhishListController>(() => WhishListController());
  }
}
