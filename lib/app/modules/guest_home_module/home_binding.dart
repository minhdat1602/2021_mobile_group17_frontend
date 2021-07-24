import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_home_module/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
