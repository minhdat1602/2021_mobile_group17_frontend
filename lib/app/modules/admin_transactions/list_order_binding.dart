import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_transactions/list_order_controller.dart';

class ListOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ListOrderController());
  }
}
