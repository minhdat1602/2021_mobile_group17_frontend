import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/data/services/contants.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/app/data/models/user_info.dart';

class AuthAPI extends GetConnect {
  Future<UserModel> signIn(String email, String password) async {
    String urlStr = "$host\/auth\/signin";
    Uri url = Uri.parse(urlStr);
    var body = utf8.encode(json.encode({"email": email, "password": password}));
    var response = await http.Client().post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      try {
        UserModel user =
            UserModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        return user;
      } catch (e) {
        print("Có gì đó sai sai: $e");
        return null;
      }
    } else {
      print("Có gì đó sai sai: ${response.statusCode}");
      return null;
    }
  }

  Future<bool> signUp(UserModel user) async {
    String urlStr = "$host\/auth\/signup";
    Uri url = Uri.parse(urlStr);
    var body = json.encode(user.toJson());
    try {
      var response =
          await http.Client().post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        return data['status'] == 'success' ? true : false;
      } else {
        print("ERROR: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("ERROR: $e");
      return false;
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/user");
    Map<String, String> headers = {"content-type": "application/json"};
    String bodys = json.encode(user.toJson());
    var response = await http.put(url, headers: headers, body: bodys);
    if (response.statusCode == 200) {
      try {
        return json.decode(utf8.decode(response.bodyBytes));
      } catch (e) {
        print("Something get wrong!${e.message}");
        return null;
      }
    } else {
      print("Something get wrong! Status code ${response.statusCode}");
      return null;
    }
  }

  Future<UserInfoModel> updateUserInfo(UserModel user) async {
    Uri url =
        Uri.parse("https://mobile2021group17.herokuapp.com/user/userInfo");
    var body = json.encode(user.toJson());
    var response;
    try {
      response = await http.put(url, headers: headers, body: body);
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (data['status'] == "success") {
        return UserInfoModel.fromJson(data['data']);
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      print("ERROR: $e");
      throw Exception(e);
    }
  }
}
