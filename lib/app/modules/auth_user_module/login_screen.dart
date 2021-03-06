import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:mobile_nhom17_2021/app/global_widgets/appbar.dart';
import 'package:sign_button/sign_button.dart';

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
        appBar: AppBarWidget(title: "login".tr),
        body: Form(
          key: _loginKey,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "login-info".tr,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  _buildEmailTf(),
                  _buildPasswordTf(context),
                  _buildLoginBtn(context),
                  _buildForgotPasswordBtn(context),
                  _buildRegisterBtn(context),
                  SizedBox(height: 50),
                  Center(
                    child: Text(
                      "- " + "or".tr + " -",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildGoogleSignIn(),
                  SizedBox(height: 15),
                  Container(
                    width: Get.width,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        // color: Colors.white,
                      ),
                      label: Text(
                        "Sign In with Facebook",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        primary: Colors.blue,
                        elevation: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildGoogleSignIn() {
    return Container(
      width: Get.width,
      child: ElevatedButton.icon(
        onPressed: () async {
          String previousRoute = Get.previousRoute;
          print("previousRoute: $previousRoute");
          await authController.googleLogin().then((value) {
            if (value == "fail") {
              Get.dialog(AlertDialog(
                title: Text("????ng nh???p th???t b???i"),
                content: Text("Vui l??ng th??? l???i !"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("OK"))
                ],
              ));
            } else if (value == "saved") {
              Get.toNamed(Routes.ACCOUNT_DETIAL);
              if (Get.isDialogOpen) Get.back();
            } else {
              if (Get.isDialogOpen) Get.back();
            }
          }); // Th???c hi???n ????ng nh???p
          // T???t Loading animation
          if (previousRoute == Routes.REVIEW) Get.back();
        },
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.orangeAccent,
          // color: Colors.blue,
        ),
        label: Text(
          "Sign In with Google",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          primary: Colors.white,
          elevation: 1,
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
        labelText: "email-address".tr,
        labelStyle: TextStyle(color: Get.theme.primaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "?????a ch??? email kh??ng ???????c b??? tr???ng";
        } else if (!GetUtils.isEmail(value)) {
          return "?????a ch??? email kh??ng h???p l???";
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
        labelText: "password".tr,
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "M???t kh???u kh??ng ???????c b??? tr???ng";
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
        onPressed: () async {
          if (_loginKey.currentState.validate()) {
            _loginKey.currentState.save();
            String previousRoute = Get.previousRoute;
            print("previousRoute: $previousRoute");
            // M??? Loading animation
            Get.dialog(
                Center(child: CircularProgressIndicator(color: Colors.white)),
                barrierDismissible: false);
            await authController.signIn(_email, _password).then((value) {
              if (!value) {
                Get.back(); // T???t Loading animation
                Get.dialog(AlertDialog(
                  title: Text("????ng nh???p th???t b???i"),
                  content: Text(
                      "Th??ng tin ????ng nh???p kh??ng ch??nh x??c, vui l??ng th??? l???i !"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("OK"))
                  ],
                ));
              } else {
                if (Get.isDialogOpen) Get.back();
                // Redirect ?????n trang ph?? h???p v???i authorization
                for (String role in authController.user.role) {
                  if (role == "ROLE_ADMIN" || role == "ROLE_DASHBOARD")
                    Get.offAllNamed(Routes.ADMIN_DASHBOARD);
                  else if (role == "ROLE_ORDER")
                    Get.offAllNamed(Routes.ADMIN_LIST_ORDER);
                  else if (role == "ROLE_PRODUCT")
                    Get.offAllNamed(Routes.ADMIN_LIST_PRODUCT);
                }
              }
            }); // Th???c hi???n ????ng nh???p
            // T???t Loading animation
            if (previousRoute == Routes.REVIEW) Get.back();
          }
        },
        child: Text("login".tr),
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
          "forgot-pw".tr,
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
          Get.toNamed(Routes.REGISTER);
        },
        child: Text("register".tr),
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
