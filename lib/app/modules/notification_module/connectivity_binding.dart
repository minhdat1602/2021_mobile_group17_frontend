import 'package:get/get.dart';
import 'connectivity_controller.dart';

class ConnectivityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
  }
}
