import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/order_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class AccountScreen extends GetWidget<AuthController> {
  ListOrderController listOrderController = Get.put(ListOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "account".tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [],
      ),
      body: GetBuilder<AuthController>(
        init: AuthController(),
        initState: (_) {},
        builder: (_) {
          return Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                _buildMyDetails(controller.user),
                SizedBox(height: 10),
                _buildChangePassword(),
                SizedBox(height: 10),
                _buildOrder(),
                SizedBox(height: 10),
                _buildSignOutBtn(),
              ],
            ),
          );
        },
      ),
    );
  }

  TextButton _logoutBtn() {
    return TextButton(
      onPressed: () {
        controller.signOut();
      },
      child: Text(
        "sign-out".tr,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSignOutBtn() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 1,
          )
        ],
      ),
      child: TextButton(
        onPressed: () {
          controller.signOut();
        },
        child: Text(
          "sign-out".tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildOrder() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
            "orders".tr,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.toNamed(Routes.MY_ORDERS);
              listOrderController.getOrdersByUser(null);
            },
            child: Text(
              "view".tr,
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

  Container _buildChangePassword() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
            "change-pw".tr,
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
              "change".tr,
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

  Container _buildMyDetails(UserModel user) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "address".tr,
            style: Get.theme.textTheme.headline2,
          ),
          SizedBox(height: 15),
          Text(
            "${user.userInfo.firstName} ${user.userInfo.lastName}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "${user.email}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "contact".tr + ": ${user.userInfo.phone}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "address".tr +
                ": ${user.userInfo.sonha}, ${user.userInfo.xa}, ${user.userInfo.huyen}, ${user.userInfo.tinh}",
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
                "edit".tr,
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
    );
  }
}
