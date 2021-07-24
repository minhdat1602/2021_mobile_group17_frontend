import 'package:get/get.dart';

import 'notifications_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
