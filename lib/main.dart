import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/core/theme/app_theme.dart';
import 'package:mobile_nhom17_2021/app/core/utils/translates.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:mobile_nhom17_2021/app/screens/web/product_screen/rating.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Giày ANT",
      debugShowCheckedModeBanner: false,
      translations: Translates(), // Thay đổi ngôn ngữ
      initialRoute: Routes.INITIAL, // khởi tạo routeName
      // initialRoute: Routes.ADMIN_ADD_PRODUCT,
      // home: RatingScreen(),
      locale: Locale('vi', 'VN'), // vị trí để thay đổi ngôn ngữ
      theme: appThemeData,
      getPages: AppPages.pages, // routeName
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
  );
}
