import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/status_controller.dart';

class StatusBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusController>(() => StatusController());
  }
}
