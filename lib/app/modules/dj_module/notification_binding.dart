import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/dj_module/notifications_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
