import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/root_util.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_home_module/home_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_menu_module/menu_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_whishlist_module/whishlist_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavController extends GetxController {
  final ptController = PersistentTabController();
  // get ptController => this._ptController;
  // set ptController(dynamic value) => this._ptController.value = value;

  @override
  void onInit() {
    ptController.index = 0;
    super.onInit();
  }
}
