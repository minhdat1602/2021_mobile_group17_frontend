import 'dart:convert';

import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sprefs = SharedPreferences.getInstance();

User getUserFromSprefs() {
  String userStr;
  sprefs.then((value) {
    userStr = value.getString("user");
  });

  return userStr == null ? null : User.fromJson(json.decode(userStr));
}

void saveUserToSprefs(User user) async {
  SharedPreferences sprefs = await SharedPreferences.getInstance();
  sprefs.setString("user", json.encode(user.toJson()));
}
