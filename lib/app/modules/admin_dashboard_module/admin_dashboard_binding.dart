import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/admin_dashboard_controller.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }
}
