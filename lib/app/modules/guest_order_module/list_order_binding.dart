import 'package:get/get.dart';

import 'order_controller.dart';

class ListOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ListOrderController());
  }
}
