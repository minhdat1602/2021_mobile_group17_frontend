import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/bottom_nav_module/bottom_nav_controller.dart';

class BottomNavBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavController>(BottomNavController());
  }
}
