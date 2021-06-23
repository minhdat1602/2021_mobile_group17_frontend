import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';

class ChangePasswordScreen extends StatefulWidget {
  static String routeName = "change-password";
  final User user;
  const ChangePasswordScreen({Key key, this.user}) : super(key: key);
  @override
  _ChangePasswordScreen createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  String _newPassword, _oldPassword, _confirmNewPassword;
  final _changePasswordForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "Thay đổi mật khẩu",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [],
      ),
      body: SafeArea(
        child: Form(
          key: _changePasswordForm,
          child: Container(
            width: double.infinity,
            height: 300,
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
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Thay đổi mật khẩu", style: Styles.headingStyle),
                Text("Thay đổi mật khẩu"),
                _buildOldPasswordTf(),
                _buildNewPasswordTf(),
                _buildConfirmNewPasswordTf(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _changePasswordForm.currentState.save();
                        if (_changePasswordForm.currentState.validate()) {
                          widget.user.password = _newPassword;
                          // updateUser(widget.user).then(
                          //   (value) => {
                          //     Navigator.pop(context),
                          //   },
                          // );
                        }
                      },
                      child: Text(
                        "Thay đổi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildOldPasswordTf() {
    return TextFormField(
      onSaved: (value) => _oldPassword = value,
      // cursorColor: Styles.secondaryColor,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Mật khẩu cũ",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập mật khẩu";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildNewPasswordTf() {
    return TextFormField(
      onSaved: (value) => _newPassword = value,
      // cursorColor: Styles.secondaryColor,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Mật khẩu mới",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập mật khẩu";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildConfirmNewPasswordTf() {
    return TextFormField(
      // cursorColor: Styles.secondaryColor,
      obscureText: true,
      onSaved: (value) => _confirmNewPassword = value,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Nhập lại",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập mật khẩu";
        } else if (value != _newPassword) {
          return "Mật khẩu không trùng khớp";
        } else {
          return null;
        }
      },
    );
  }
}
