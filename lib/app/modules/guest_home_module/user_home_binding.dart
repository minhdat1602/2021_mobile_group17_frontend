import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_home_module/user_home_controller.dart';

class UserHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserHomeController>(() => UserHomeController());
  }
}
