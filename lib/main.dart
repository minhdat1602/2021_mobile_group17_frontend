import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/core/theme/app_theme.dart';
import 'package:mobile_nhom17_2021/app/core/utils/translates.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Giày DJ",
      debugShowCheckedModeBanner: false,
      translations: Translates(), // Thay đổi ngôn ngữ
      initialRoute: Routes.INITIAL, // khởi tạo routeName
      locale: Locale('vi', 'VN'), // vị trí để thay đổi ngôn ngữ
      theme: appThemeData,
      getPages: AppPages.pages, // routeName
      defaultTransition: Transition.fade,
    ),
  );
}
