import 'package:email_validator/email_validator.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/config/styles.dart';
import 'package:mobile_nhom17_2021/http/http_signin.dart';
import 'package:mobile_nhom17_2021/screens/account_screen.dart';
import 'package:mobile_nhom17_2021/screens/register_screen.dart';
import 'package:mobile_nhom17_2021/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  String _email;
  String _password;

  Future<void> _checkLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    if (jwt != null) {
      print(jwt);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AccountScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkLogged();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
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
                  "Đăng nhập tài khoản",
                  style: Styles.headingStyle,
                ),
                _buildEmailTf(),
                _buildPasswordTf(),
                _buildLoginBtn(),
                _buildForgotPasswordBtn(),
                _buildRegisterBtn(),
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
      cursorColor: Styles.secondaryColor,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
        ),
        labelText: "Địa chỉ email",
        labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Địa chỉ email không được bỏ trống";
        } else if (!EmailValidator.validate(value)) {
          return "Địa chỉ email không hợp lệ";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildPasswordTf() {
    return TextFormField(
      onSaved: (password) => _password = password,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      cursorColor: Styles.secondaryColor,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Styles.secondaryColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5)),
        labelText: "Mật khẩu",
        labelStyle: TextStyle(color: Styles.secondaryColor),
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

  Container _buildLoginBtn() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if (_loginKey.currentState.validate()) {
            _loginKey.currentState.save();
            try {
              signin(_email, _password).then((logged) => {
                    if (logged == true)
                      {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountScreen()),
                            (Route<dynamic> route) => false)
                      }
                    else
                      {
                        showFlash(
                          context: context,
                          duration: Duration(seconds: 2),
                          builder: (context, controller) {
                            return Flash.dialog(
                              margin: EdgeInsets.only(top: 100),
                              controller: controller,
                              backgroundColor: Colors.white,
                              alignment: Alignment.topCenter,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 100,
                                width: 300,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Đại chỉ Email hoặc mật khẩu không chính xác !",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      },
                    FocusScope.of(context).requestFocus(new FocusNode()),
                  });
            } catch (e) {
              print("login err");
            }
          }
        },
        child: Text("Đăng nhập"),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          primary: Styles.secondaryColor,
        ),
      ),
    );
  }

  Container _buildForgotPasswordBtn() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () async {},
        child: Text(
          "Quên mật khẩu?",
          style: TextStyle(
            color: Color.fromARGB(255, 35, 103, 148),
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

  Container _buildRegisterBtn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        child: Text("Đăng ký"),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          primary: Styles.secondaryColor,
        ),
      ),
    );
  }
}
