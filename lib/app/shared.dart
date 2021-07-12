import 'dart:convert';

import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sprefs = SharedPreferences.getInstance();

UserModel getUserFromSprefs() {
  String userStr;
  sprefs.then((value) {
    userStr = value.getString("user");
  });

  return userStr == null ? null : UserModel.fromJson(json.decode(userStr));
}

void saveUserToSprefs(UserModel user) async {
  SharedPreferences sprefs = await SharedPreferences.getInstance();
  sprefs.setString("user", json.encode(user.toJson()));
}
