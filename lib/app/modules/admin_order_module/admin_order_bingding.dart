import 'package:get/get.dart';

import 'admin_order_controller.dart';
import 'admin_status_controller.dart';

class AdminOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminOrderController>(() => AdminOrderController());
    Get.lazyPut<AdminStatusController>(() => AdminStatusController());
  }
}
