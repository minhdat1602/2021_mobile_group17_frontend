import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/menu_controller.dart';

class MenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }
}
