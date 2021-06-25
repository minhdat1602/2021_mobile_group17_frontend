import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_nhom17_2021/app/models/cart.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:mobile_nhom17_2021/app/models/user_info.dart';
import 'package:mobile_nhom17_2021/app/services/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthAPI authAPI = Get.put<AuthAPI>(AuthAPI());

  SharedPreferences sprefs;
  //models
  Rx<User> _user = User().obs;

  //tgeter setter
  get user => this._user.value;
  set(User user) => this._user.value = user;

  final box = GetStorage();

  @override
  void onInit() {
    initUser();
    super.onInit();
  }

  void initUser() {
    String userStr = box.read("user");
    if (userStr != null) {
      _user.value = User.fromJson(json.decode(userStr));
    }
  }

  void signOut() {
    try {
      _user.value = User();
      box.remove("user");
    } catch (e) {
      Get.snackbar(
        "Đăng xuất thất bại",
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
      );
    }
  }

  void signIn(String email, String password) async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()));
      _user.value = await authAPI.signIn(email, password);
      Get.back();
      if (_user.value == null) {
        Get.snackbar(
          "Đăng nhập thất bại !",
          "Email hoặc mật khẩu không chính xác",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
        );
        _user.value = User();
      } else {
        print("user id: ${_user.value.id}");
        // Đăng nhập thành công => Thêm user vào shopping-cart
        Cart cart = Cart.fromJson(json.decode(box.read("cart")));
        cart.user = _user.value;
        box.write("cart", json.encode(cart.toJson()));
        box.write("user", json.encode(_user.value.toJson()));
      }
    } catch (e) {
      Get.snackbar(
        "Đăng nhập thất bại !",
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
      );
      _user.value = User();
    }
  }

  void signUp(User user) async {
    try {
      // Đăng ký
      Get.dialog(Center(child: CircularProgressIndicator()));
      bool logged = await authAPI.signUp(user);
      Get.back();

      if (logged) {
        Get.back();
        Get.snackbar(
          "",
          "Đăng ký thành công",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar(
          "Đăng ký thất bại !",
          "Địa chỉ email đã tồn tại !",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Đã xảy ra lỗi trong quá trình đăng ký !",
        "Vui lòng trở lại sau ! ${e.message}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
      );
    }
  }

  void updateUser() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    User result = await authAPI.updateUser(_user.value);
    Get.back();
    if (result == null) {
      _user.value = User.fromJson(json.decode(box.read("user")));
      Get.snackbar(
        "Cập nhất thất bại !",
        "Vui lòng thử lại sau !",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      _user.value = result;
      Get.back();
      Get.snackbar(
        "Cập nhất thành công !",
        "Thông tin đã được cập nhật !",
        snackPosition: SnackPosition.TOP,
      );
      box.write("user", json.encode(result.toJson()));
    }
  }

  void updateUserInfo() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    UserInfo result = await authAPI.updateUserInfo(_user.value.userInfo);
    Get.back();
    if (result == null) {
      _user.value = User.fromJson(json.decode(box.read("user")));
      Get.snackbar(
        "Cập nhất thất bại !",
        "Vui lòng thử lại sau !",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      _user.value.userInfo = result;
      Get.back();
      Get.snackbar(
        "Cập nhất thành công !",
        "Thông tin đã được cập nhật !",
        snackPosition: SnackPosition.TOP,
      );
      box.write("user", json.encode(result.toJson()));
    }
  }
}
