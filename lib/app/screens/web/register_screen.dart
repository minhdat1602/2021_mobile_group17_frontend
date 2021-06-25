import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:mobile_nhom17_2021/app/models/user_info.dart';

import 'global_widgets/appbar.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signupForm = GlobalKey<FormState>();
  String _firstName, _lastName, _email, _password, _phone;
  String _sonha, _xa, _huyen, _tinh;

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBarWidget(title: "Đăng ký"),
        body: Form(
          key: _signupForm,
          child: ListView(
            children: [
              _buildMyDetailForm(),
              _buildDeliveryAddressForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildMyDetailForm() {
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
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Thông tin chi tiết", style: Get.theme.textTheme.headline2),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: _buildFirstNameTf(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: _buildLastNameTf(),
                ),
              ),
            ],
          ),
          _buildEmailTf(),
          _buildPhoneTf(),
          _buildPasswordTf(),
          _buildConfirmPasswordTf(),
        ],
      ),
    );
  }

  Container _buildDeliveryAddressForm(BuildContext context) {
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
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Địa chỉ chi tiết",
              style: Theme.of(context).textTheme.headline2),
          _buildSoNhaTf(),
          _buildXaTf(),
          _buildHuyenTf(),
          _buildTinhTf(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _signupForm.currentState.reset();
                },
                child: Text(
                  "Xóa",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[400],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _signupForm.currentState.save();
                  if (_signupForm.currentState.validate()) {
                    // user info
                    UserInfo userInfo = new UserInfo();
                    userInfo.firstName = _firstName;
                    userInfo.lastName = _lastName;
                    userInfo.phone = _phone;
                    userInfo.sonha = _sonha;
                    userInfo.xa = _xa;
                    userInfo.huyen = _huyen;
                    userInfo.tinh = _tinh;
                    // user
                    User user = new User();
                    user.email = _email;
                    user.password = _password;
                    user.userInfo = userInfo;
                    user.role = [];

                    authController.signUp(user);
                  }
                },
                child: Text(
                  "Đăng ký",
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
    );
  }

  TextFormField _buildConfirmPasswordTf() {
    return TextFormField(
      // cursorColor: Styles.secondaryColor,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Nhập lại mật khẩu",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Xác nhận mật khẩu";
        } else if (value != _password) {
          return "Mật khẩu không khớp !";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildPasswordTf() {
    return TextFormField(
      onSaved: (value) => _password = value,
      // cursorColor: Styles.secondaryColor,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Mật khẩu",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập Mật khẩu";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildSoNhaTf() {
    return TextFormField(
      onSaved: (value) => _sonha = value,
      // cursorColor: Styles.secondaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Số nhà/Tên đường",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập số nhà";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildXaTf() {
    return TextFormField(
      onSaved: (value) => _xa = value,
      // cursorColor: Styles.secondaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Xã/Phường",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập xã/phường";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildHuyenTf() {
    return TextFormField(
      onSaved: (value) => _huyen = value,
      // cursorColor: Styles.secondaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Huyện/Quận",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập quận/huyện";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildTinhTf() {
    return TextFormField(
      onSaved: (value) => _tinh = value,
      // cursorColor: Styles.secondaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Tỉnh/Thành phố",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập tỉnh/thành phố";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildEmailTf() {
    return TextFormField(
      onSaved: (value) => _email = value,
      // cursorColor: Styles.secondaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Địa chỉ email",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập email";
        } else if (!EmailValidator.validate(value)) {
          return "Email không hợp lệ !";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildPhoneTf() {
    return TextFormField(
      onSaved: (value) => _phone = value,
      // cursorColor: Styles.secondaryColor,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Số điện thoại",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Nhập số điện thoại";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildLastNameTf() {
    return TextFormField(
      onSaved: (value) => _lastName = value,
      // cursorColor: Styles.secondaryColor,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Tên",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập tên";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildFirstNameTf() {
    return TextFormField(
      onSaved: (value) => _firstName = value,
      // cursorColor: Styles.secondaryColor,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Họ",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập họ";
        } else {
          return null;
        }
      },
    );
  }
}
