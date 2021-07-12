import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';

import 'account_screen.dart';
import 'login_screen.dart';

class Root extends GetWidget<AuthController> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.user.id == null) {
        return LoginScreen();
      } else {
        return AccountScreen();
      }
    });
  }
}
