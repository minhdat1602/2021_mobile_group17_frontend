import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_nhom17_2021/models/user.dart';
import 'package:mobile_nhom17_2021/screens/change_password.dart';
import 'package:mobile_nhom17_2021/screens/login_screen.dart';
import 'package:mobile_nhom17_2021/screens/my_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User user;
  @override
  void initState() {
    super.initState();
  }

  Future<User> initUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user;
    try {
      user = User.fromJson(json.decode(prefs.getString("user")));
    } catch (e) {
      print(e);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
    return user;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "Tài khoản",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              logout().then((value) {
                setState(() {});
              });
            },
            child: Text(
              "Đăng xuất",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: FutureBuilder(
        future: initUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                _buildMyDetails(snapshot.data),
                _buildChangePassword(snapshot.data),
                _buildOrder(snapshot.data),
              ],
            );
          } else {
            return SpinKitPouringHourglass(
              color: Colors.black,
              size: 100,
            );
          }
        },
      ),
    );
  }

  Container _buildOrder(User user) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15.0),
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
            "Quản lý đơn hàng",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "XEM",
            style: TextStyle(
              color: Colors.indigo[400],
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildChangePassword(User user) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(15.0),
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
            "Thay đổi mật khẩu",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()));
            },
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangePasswordScreen(user: user)));
              },
              child: Text(
                "Thay đổi",
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

  Container _buildMyDetails(User user) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(15.0),
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
            "Địa chỉ nhận hàng",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
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
            "phone: ${user.userInfo.phone}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "address: ${user.userInfo.sonha} - ${user.userInfo.xa} - ${user.userInfo.huyen} - ${user.userInfo.tinh}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyDetailsScreen()));
              },
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyDetailsScreen(user: user)));
                },
                child: Text(
                  "Chỉnh sửa",
                  style: TextStyle(
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
