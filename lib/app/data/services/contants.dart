import 'dart:io';

import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';

AuthController authController = Get.put(AuthController());
final Map<String, String> headers = authController.user.id == 0
    ? {
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      }
    : {
        "Content-Type": "application/json",
        "Connection": "keep-alive",
        HttpHeaders.authorizationHeader:
            "${authController.user.tokenType} ${authController.user.tokenType}"
      };

final String host = "https://mobile2021group17.herokuapp.com";
