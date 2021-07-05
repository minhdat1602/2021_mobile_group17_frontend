import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/status_controller.dart';

class StatusBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusController>(() => StatusController());
  }
}
