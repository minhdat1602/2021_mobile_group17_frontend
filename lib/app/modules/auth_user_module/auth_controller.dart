import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/data/models/user_info.dart';
import 'package:mobile_nhom17_2021/app/data/services/auth_api.dart';

class AuthController extends GetxController {
  final AuthAPI authAPI = Get.put<AuthAPI>(AuthAPI());
  Rx<UserModel> _user = UserModel().obs;

  //tgeter setter
  get user => this._user.value;
  set(UserModel user) => this._user.value = user;

  final box = GetStorage();
  final googleSignIn = GoogleSignIn();
  // FirebaseAuth _firebaseAuth;
  // GoogleSignIn _googleSignIn;

  @override
  void onInit() {
    initUser();

    // _firebaseAuth = FirebaseAuth.instance;
    // _googleSignIn = new GoogleSignIn();

    super.onInit();
  }

  void initUser() {
    String userStr = box.read("user");
    if (userStr != null) {
      _user.value = UserModel.fromJson(json.decode(userStr));
    }
  }

  void signOut() {
    _user.value = UserModel();
    box.remove("user");

    try {
      googleSignIn.signOut();
    } catch (e) {}
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserModel user = await authAPI.signIn(email, password);

      if (user == null) {
        return false;
      } else {
        _user.value = user;
        print("user id: ${_user.value.id}");

        // Đăng nhập thành công => Thêm user vào shopping-cart
        Cart cart = Cart.fromJson(json.decode(box.read("cart")));
        cart.user = _user.value;
        box.write("cart", json.encode(cart.toJson()));
        box.write("user", json.encode(_user.value.toJson()));

        return true;
      }
    } catch (e) {
      print(e);
      return false;
      // _user.value = UserModel();
    }
  }

  Future<bool> signUp(UserModel user) async {
    try {
      bool signup = await authAPI.signUp(user);
      return signup;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    UserModel result = await authAPI.updateUser(_user.value);
    if (result == null) {
      return false;
    } else {
      _user.value = result;
      box.write("user", json.encode(_user.value));
      return true;
    }
  }

  Future<bool> updateUserInfo(UserInfoModel userInfox) async {
    UserModel user = UserModel()
      ..id = _user.value.id
      ..userInfo = userInfox;
    var result = await authAPI.updateUserInfo(user);
    if (result == null) {
      return false;
    } else {
      _user.value.userInfo = result;
      box.write("user", json.encode(_user.value)); // update get storage
      return true;
    }
  }

  Future<String> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    Get.dialog(Center(child: CircularProgressIndicator(color: Colors.white)),
        barrierDismissible: false); // Mở Loading animation
    if (googleUser == null) {
      return "fail";
    } else {
      UserModel usermodel = new UserModel()
        ..email = googleUser.email
        ..password = googleUser.id;
      bool isLogged = await signIn(usermodel.email, usermodel.password);

      if (isLogged) {
        // Đăng nhập thành công
        return "logged";
      } else {
        // Đăng nhập thất bại, tiến hành đăng ký => Đăng nhập
        List<String> fullname = googleUser.displayName.split(" ");
        UserInfoModel userInfo = new UserInfoModel()
          ..firstName = fullname.first
          ..lastName = fullname.last;
        usermodel
          ..userInfo = userInfo
          ..role = [];

        // Đăng ký
        bool signup = await signUp(usermodel);
        if (signup) {
          // Đăng nhập
          isLogged = await signIn(usermodel.email, usermodel.password);
          return isLogged ? "saved" : "fail";
        } else {
          return "fail";
        }
      }
    }
  }

  bool isPermission(String permission) {
    if (user.id == 0)
      return false;
    else {
      List<String> role = user.role;
      for (String r in role) {
        if (r == permission) return true;
      }
      return false;
    }
  }

  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  // User getCurrentUser() => FirebaseAuth.instance.currentUser;

  // Future signOutGoogle() async {
  //   await _googleSignIn.signOut();
  //   await _firebaseAuth.signOut();
  // }
}
