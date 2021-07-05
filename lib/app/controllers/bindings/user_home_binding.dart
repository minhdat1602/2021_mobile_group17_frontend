import 'package:get/get.dart';

import '../user_home_controller.dart';

class UserHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserHomeController>(() => UserHomeController());
  }
}
