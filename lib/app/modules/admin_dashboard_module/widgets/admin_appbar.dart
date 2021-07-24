import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';

class AdminAppBar extends StatelessWidget with PreferredSizeWidget {
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff11101d),
          brightness: Brightness.dark,
        ),
        backgroundColor: Color(0xFF212332),
        primaryColor: Color(0xFF2697FF),
        accentColor: Color(0xFF2A2D3E),
      ),
      child: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Tìm kiếm",
            hintStyle: TextStyle(color: Colors.white70),
            fillColor: Color(0xFF1d1b31),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16 * 0.75),
                margin: EdgeInsets.symmetric(horizontal: 16 / 2),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2D3E),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset("assets/icons/Search.svg"),
              ),
            ),
          ),
        ),
        actions: [
          Container(
            width: Get.width / 3,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16 / 2),
                  child: Obx(
                      () => Text("${authController.user.userInfo.lastName}")),
                ),
                Expanded(child: Icon(Icons.keyboard_arrow_down)),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
