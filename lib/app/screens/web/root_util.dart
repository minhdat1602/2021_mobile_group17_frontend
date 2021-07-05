import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/screens/web/account_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/login_screen.dart';

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
