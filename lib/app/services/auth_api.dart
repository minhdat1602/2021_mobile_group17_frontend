import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:mobile_nhom17_2021/app/data/provider/contants.dart';
import 'package:http/http.dart' as http;

class AuthAPI extends GetConnect {
  Future<User> signIn(String email, String password) async {
    String urlStr = "$host\/auth\/signin";
    Uri url = Uri.parse(urlStr);
    var body = utf8.encode(json.encode({"email": email, "password": password}));
    var response = await http.Client().post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      try {
        User user = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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

  Future<bool> signUp(User user) async {
    String urlStr = "$host\/auth\/signup";
    Uri url = Uri.parse(urlStr);
    var body = json.encode(user.toJson());
    var response = await http.Client().post(
      url,
      headers: headers,
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200) {
      try {
        print(json.decode(response.body)['message']);
      } catch (e) {
        print("Có gì đó sai sai");
      }
      return true;
    } else {
      print("Có gì đó sai sai: ${response.statusCode}");
      return false;
    }
  }
}
