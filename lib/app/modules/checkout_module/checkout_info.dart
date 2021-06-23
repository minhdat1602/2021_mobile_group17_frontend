import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/services/auth_api.dart';
import 'package:mobile_nhom17_2021/app/data/provider/checkout_api.dart';
import 'package:mobile_nhom17_2021/app/data/provider/shop_api.dart';
import 'package:mobile_nhom17_2021/app/global_widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/checkout_module/checkout_controller.dart';
import 'package:mobile_nhom17_2021/app/controllers/shop_controller.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String _deliveryMethod = "giaohangtietkiem";
  String _paymentMethod = "cod";
  String _email, _password;
  final _loginCheckoutForm = GlobalKey<FormState>();

  AuthController authController = Get.put(AuthController());
  ShopController shopController = Get.put(ShopController());
  CheckoutController checkoutController =
      Get.put(CheckoutController(checkoutAPI: CheckoutAPI()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Thông tin thanh toán"),
      body: ListView(
        children: [
          authController.user == null ? _loginForm() : _buildAddress(),
          SizedBox(height: 20),
          _buildDeliveryMethod(),
          _buildPaymentMethod(),
          _buildMoney(),
          _buildCheckout(),
        ],
      ),
    );
  }

  Form _loginForm() {
    return Form(
      key: _loginCheckoutForm,
      child: Container(
        width: double.infinity,
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
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Đăng nhập", style: Get.theme.textTheme.headline1),
            TextFormField(
              onSaved: (email) => _email = email,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Get.theme.primaryColor,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Get.theme.primaryColor, width: 2.5),
                ),
                labelText: "Địa chỉ email",
                labelStyle: TextStyle(color: Get.theme.primaryColor),
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
            ),
            TextFormField(
              onSaved: (password) => _password = password,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Get.theme.primaryColor,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Get.theme.primaryColor, width: 2.5)),
                labelText: "Mật khẩu",
                labelStyle: TextStyle(color: Get.theme.primaryColor),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Mật khẩu không được bỏ trống";
                } else {
                  return null;
                }
              },
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_loginCheckoutForm.currentState.validate()) {
                    _loginCheckoutForm.currentState.save();
                    authController.signIn(_email, _password);
                    setState(() {});
                  }
                },
                child: Text("Đăng nhập"),
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  primary: Get.theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCheckout() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Thành tiền", style: TextStyle(color: Colors.redAccent)),
              Text(
                "${PriceUtil.toCurrency(shopController.cart.value.totalPrice() - shopController.cart.value.totalDiscount() - 20000)} VNĐ",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {
                if (!authController.user.id == null) {
                  Get.rawSnackbar(message: "Bạn chưa đăng nhập !");
                } else {
                  checkoutController.checkout(
                      shopController.cart.value, authController.user);
                }
              },
              child: Text(
                "Đặt hàng",
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent,
                primary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildMoney() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tạm tính"),
              Text(
                  "${PriceUtil.toCurrency(shopController.cart.value.totalPrice() - shopController.cart.value.totalDiscount())} đ"),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Phí vận chuyển"),
              Text("20,000 đ"),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildDeliveryMethod() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
          Text(
            "Chọn hình thức giao hàng",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 5),
              RadioListTile(
                title: const Text('Giao hàng tiết kiệm'),
                value: "giaohangtietkiem",
                groupValue: _deliveryMethod,
                activeColor: Colors.blue,
                tileColor: Colors.grey[100],
                onChanged: (value) {
                  setState(() {
                    _deliveryMethod = value;
                  });
                },
              ),
              SizedBox(height: 5),
              RadioListTile(
                title: const Text('Thanh toán nhanh'),
                value: "giaohangnhanh",
                groupValue: _deliveryMethod,
                activeColor: Colors.blue,
                tileColor: Colors.grey[100],
                onChanged: (value) {
                  setState(() {
                    _deliveryMethod = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildPaymentMethod() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
          Text(
            "Chọn hình thức thanh toán",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 5),
              RadioListTile(
                title: const Text('COD'),
                value: "cod",
                groupValue: _paymentMethod,
                activeColor: Colors.blue,
                tileColor: Colors.grey[100],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
              SizedBox(height: 5),
              RadioListTile(
                title: const Text('Thanh toán Momo'),
                value: "momo",
                groupValue: _paymentMethod,
                activeColor: Colors.blue,
                tileColor: Colors.grey[100],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildAddress() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Địa chỉ nhận hàng",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Thay đổi",
                  style: TextStyle(
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${authController.user.userInfo.firstName} ${authController.user.userInfo.lastName} - ${authController.user.userInfo.phone}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "${authController.user.userInfo.sonha} - ${authController.user.userInfo.xa} - ${authController.user.userInfo.huyen} - ${authController.user.userInfo.tinh}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
