import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/bottom_nav_controller.dart';

class BottomNavBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavController>(BottomNavController(), permanent: true);
  }
}
