import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:mobile_nhom17_2021/app/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  Future<bool> updateUser(User user) async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/user");
    Map<String, String> headers = {"content-type": "application/json"};
    String bodys = json.encode(user.toJson());
    print(json.encode(bodys));
    var response = await http.put(url, headers: headers, body: bodys);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      try {
        String userJson = json.decode(response.body);
        if (userJson != null) {
          SharedPreferences sprefs = await SharedPreferences.getInstance();
          sprefs.setString("user", userJson);
          return true;
        } else {
          return false;
        }
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

  Future<bool> updateUserInfo(UserInfo userInfo) async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/userInfo");
    Map<String, String> headers = {
      "content-type": "application/json",
      "charset": "utf8"
    };
    String bodys = json.encode(userInfo.toJson());
    // print(json.encode(bodys));
    var response = await http.put(url, headers: headers, body: bodys);
    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      try {
        String userInfoJson = json.decode(response.body); // userInfo sau update
        if (userInfoJson != null) {
          SharedPreferences sprefs = await SharedPreferences.getInstance();
          User user = User.fromJson(
              json.decode(sprefs.getString("user"))); // lấy user từ sprefs
          user.userInfo =
              UserInfo.fromJson(json.decode(userInfoJson)); // cập nhật userInfo
          sprefs.setString(
              "user", json.encode(user.toJson())); // lưu lại sprefs
          return true;
        } else {
          return false;
        }
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

  Future<bool> insert(User user) async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/user");
    Map<String, String> headers = {
      "content-type": "application/json",
      "charset": "utf8"
    };
    String bodys = json.encode(user.toJson());
    // print(json.encode(bodys));
    var response = await http.post(url, headers: headers, body: bodys);
    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      try {
        String userJson = json.decode(response.body);
        if (user != null) {
          SharedPreferences sprefs = await SharedPreferences.getInstance();
          sprefs.setString("user", userJson);
          return true;
        } else {
          return false;
        }
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
}
