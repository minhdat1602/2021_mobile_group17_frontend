import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
