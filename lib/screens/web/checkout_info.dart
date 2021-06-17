import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_nhom17_2021/config/styles.dart';

import 'package:mobile_nhom17_2021/models/cart.dart';
import 'package:mobile_nhom17_2021/models/user.dart';
import 'package:mobile_nhom17_2021/screens/web/order_detail.dart';
import 'package:mobile_nhom17_2021/service/checkout_service.dart';
import 'package:mobile_nhom17_2021/service/signin_service.dart';
import 'package:mobile_nhom17_2021/utils/price_toVnd.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutScreen extends StatefulWidget {
  static String routeName = "/checkout";
  final Cart cart;
  const CheckOutScreen({Key key, this.cart}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String _deliveryMethod = "giaohangtietkiem";
  String _paymentMethod = "cod";
  String _email, _password;
  final _loginCheckoutForm = GlobalKey<FormState>();

  Future<User> getUserFromSprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user;
    try {
      user = User.fromJson(json.decode(prefs.getString("user")));
    } catch (e) {
      user = new User();
      print(e);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "Xác nhận đơn hàng",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: getUserFromSprefs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                snapshot.data.id == null
                    ? _loginForm()
                    : _buildAddress(snapshot.data),
                SizedBox(height: 20),
                // _buildAddress(),
                _buildDeliveryMethod(),
                _buildPaymentMethod(),
                _buildMoney(),
                _buildCheckout(snapshot.data),
              ],
            );
          } else {
            return SpinKitCircle(
              size: 75,
            );
          }
        },
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
            Text(
              "Đăng nhập",
              style: Styles.headingStyle,
            ),
            TextFormField(
              onSaved: (email) => _email = email,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Styles.secondaryColor,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Styles.secondaryColor, width: 2.5),
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
            ),
            TextFormField(
              onSaved: (password) => _password = password,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Styles.secondaryColor,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Styles.secondaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.secondaryColor, width: 2.5)),
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
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_loginCheckoutForm.currentState.validate()) {
                    _loginCheckoutForm.currentState.save();
                    try {
                      // FutureBuilder(
                      //   future: signin(_email, _password),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       if (snapshot.data == true) {
                      //         setState(() {});
                      //       } else {
                      //         showFlash(
                      //           context: context,
                      //           duration: Duration(seconds: 2),
                      //           builder: (_, controller) {
                      //             return Flash.dialog(
                      //               margin: EdgeInsets.only(top: 100),
                      //               controller: controller,
                      //               backgroundColor: Colors.white,
                      //               alignment: Alignment.topCenter,
                      //               borderRadius: BorderRadius.circular(15),
                      //               child: Container(
                      //                 height: 100,
                      //                 width: 300,
                      //                 alignment: Alignment.center,
                      //                 padding: EdgeInsets.all(20),
                      //                 child: Text(
                      //                   "Đại chỉ Email hoặc mật khẩu không chính xác !",
                      //                   style: TextStyle(
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //         FocusScope.of(context)
                      //             .requestFocus(new FocusNode());
                      //       }
                      //     } else {
                      //       return SpinKitCircle();
                      //     }
                      //   },
                      // );
                      signin(_email, _password).then((logged) => {
                            if (logged)
                              {
                                print("login for checkout successful..."),
                                setState(() {})
                              }
                            else
                              {
                                showFlash(
                                  context: context,
                                  duration: Duration(seconds: 2),
                                  builder: (_, controller) {
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
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()),
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
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCheckout(User user) {
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
                "${PriceUtil.toCurrency(widget.cart.totalPrice() - widget.cart.totalDiscount() - 20000)} VNĐ",
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
                if (user.id == null) {
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
                          height: 70,
                          width: 350,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Bạn chưa đăng nhập !",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  FocusScope.of(context).requestFocus(new FocusNode());
                } else {
                  checkout(widget.cart, user).then((order) async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
                        ),
                        (route) => false);
                    SharedPreferences sprefs =
                        await SharedPreferences.getInstance();
                    Cart cart =
                        Cart.fromJson(json.decode(sprefs.getString("cart")));
                    cart.cartItems = [];
                    sprefs.setString("cart", json.encode(cart.toJson()));
                  });
                  // checkout xong
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
                  "${PriceUtil.toCurrency(widget.cart.totalPrice() - widget.cart.totalDiscount())} VNĐ"),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Phí vận chuyển"),
              Text("20,000 VNĐ"),
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

  Container _buildAddress(User user) {
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
            "${user.userInfo.firstName} ${user.userInfo.lastName} - ${user.userInfo.phone}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "${user.userInfo.sonha} - ${user.userInfo.xa} - ${user.userInfo.huyen} - ${user.userInfo.tinh}",
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
