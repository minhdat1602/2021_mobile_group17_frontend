import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/models/user.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> signin(String email, String password) async {
  Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/auth/signin");
  Map<String, String> headers = {
    "content-type": "application/json",
    "charset": "utf8"
  };
  Map<String, String> bodys = {"email": email, "password": password};
  print(json.encode(bodys));
  var response =
      await http.post(url, headers: headers, body: json.encode(bodys));
  print(json.decode(response.body));
  if (response.statusCode == 200) {
    try {
      // User user = User.fromJson(json.decode(response.body));
      // String tokenType = data["tokenType"];
      // String accessToken = data["accessToken"];
      // int userid = data["id"];

      SharedPreferences sprefs = await SharedPreferences.getInstance();
      sprefs.setString("user", response.body);
      // prefs.setString("Bearer", "$tokenType $accessToken");
      // prefs.setString("user", response.body);

      // print("userid:$userid");
      return true;
    } catch (e) {
      print(e.getMessage());
      print("Something get wrong!");
      return false;
    }
  } else {
    print("Something get wrong! Status code ${response.statusCode}");
    return false;
  }
}

Future<bool> signup(User user) async {
  Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/auth/signup");
  Map<String, String> headers = {
    "Content-type": "application/json;charset=utf-8"
  };
  String bodys = json.encode(user.toJson());
  var bodysUtf8 = utf8.encode(bodys);
  var response = await http.post(url, headers: headers, body: bodysUtf8);
  if (response.statusCode == 200) {
    try {
      print(json.decode(response.body)['message']);
    } catch (e) {
      print(e);
    }
    return true;
  } else {
    print("Something get wrong! Status code ${response.statusCode}");
    return false;
  }
}
