import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/dj_module/connectivity_controller.dart';

class ConnectivityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
  }
}
