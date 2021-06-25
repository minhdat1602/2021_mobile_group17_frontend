import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/auth_controller.dart';

import 'global_widgets/appbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  String _email;
  String _password;

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBarWidget(title: "Đăng nhập"),
        body: Form(
          key: _loginKey,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thôn tin đăng nhập",
                  style: Theme.of(context).textTheme.headline3,
                ),
                _buildEmailTf(),
                _buildPasswordTf(context),
                _buildLoginBtn(context),
                _buildForgotPasswordBtn(context),
                _buildRegisterBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildEmailTf() {
    return TextFormField(
      onSaved: (email) => _email = email,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Get.theme.primaryColor,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 2.5),
        ),
        labelText: "Địa chỉ email",
        labelStyle: TextStyle(color: Get.theme.primaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Địa chỉ email không được bỏ trống";
        } else if (!GetUtils.isEmail(value)) {
          return "Địa chỉ email không hợp lệ";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildPasswordTf(BuildContext context) {
    return TextFormField(
      onSaved: (password) => _password = password,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.5)),
        labelText: "Mật khẩu",
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Mật khẩu không được bỏ trống";
        } else {
          return null;
        }
      },
    );
  }

  Container _buildLoginBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if (_loginKey.currentState.validate()) {
            _loginKey.currentState.save();
            authController.signIn(_email, _password);
          }
        },
        child: Text("Đăng nhập"),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          primary: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Container _buildForgotPasswordBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () async {},
        child: Text(
          "Quên mật khẩu?",
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          primary: Colors.transparent,
        ),
      ),
    );
  }

  Container _buildRegisterBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed("/register");
        },
        child: Text("Đăng ký"),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          primary: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
