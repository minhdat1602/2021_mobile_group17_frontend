import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/whishlist_controller.dart';

class WhishListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhishListController>(() => WhishListController());
  }
}
