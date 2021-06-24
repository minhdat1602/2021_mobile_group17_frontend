import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/models/cart.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
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

  @override
  void onInit() {
    super.onInit();
  }

  void signOut() {
    try {
      _user.value = User();
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
      _user.value = await authAPI.signIn(email, password);
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
        sprefs = await SharedPreferences.getInstance();
        Cart cart = Cart.fromJson(json.decode(sprefs.getString("cart")));
        cart.user = _user.value;
        sprefs.setString("cart", json.encode(cart.toJson()));
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
      if (await authAPI.signUp(user)) {
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
          "Vui lòng trở lại sau !",
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
}
