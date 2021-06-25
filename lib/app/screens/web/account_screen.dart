import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class AccountScreen extends GetWidget<AuthController> {
  // AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 2));
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "Tài khoản",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          _logoutBtn(),
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          _buildMyDetails(),
          _buildChangePassword(),
          _buildOrder(),
        ],
      ),
    );
  }

  TextButton _logoutBtn() {
    return TextButton(
      onPressed: () {
        controller.signOut();
      },
      child: Text(
        "Đăng xuất",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildOrder() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey[300],
          )
        ],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Quản lý đơn hàng",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "XEM",
            style: TextStyle(
              color: Colors.indigo[400],
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildChangePassword() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey[300],
          )
        ],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Thay đổi mật khẩu",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed("/change-password");
            },
            child: Text(
              "Thay đổi",
              style: TextStyle(
                color: Colors.indigo[400],
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildMyDetails() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey[300],
          )
        ],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Địa chỉ nhận hàng",
              style: Get.theme.textTheme.headline2,
            ),
            SizedBox(height: 15),
            Text(
              "${controller.user.userInfo.firstName} ${controller.user.userInfo.lastName}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "${controller.user.email}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "phone: ${controller.user.userInfo.phone}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "address: ${controller.user.userInfo.sonha} - ${controller.user.userInfo.xa} - ${controller.user.userInfo.huyen} - ${controller.user.userInfo.tinh}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.ACCOUNT_DETIAL);
                },
                child: Text(
                  "Chỉnh sửa",
                  style: TextStyle(
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
