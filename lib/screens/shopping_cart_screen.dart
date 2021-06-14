import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/config/styles.dart';
import 'package:mobile_nhom17_2021/models/cart.dart';
import 'package:mobile_nhom17_2021/models/cart_item.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/screens/checkout_info.dart';
import 'package:mobile_nhom17_2021/utils/PriceUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartScreen extends StatefulWidget {
  ShoppingCartScreen();
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  String _coupon;
  // Cart cart;
  @override
  void initState() {
    // initCart();

    super.initState();
  }

  Future<Cart> initCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cart cart;
    try {
      cart = Cart.fromJson(json.decode(prefs.getString("cart")));
    } catch (e) {
      print(e);
    }
    if (cart == null) {
      cart = new Cart();
      cart.cartItems = [];
    }
    print(cart.toString());
    return cart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "Giỏ hàng",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: initCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  snapshot.data == null
                      ? Text("Không có sản phẩm trong giỏ hàng")
                      : _buildItems(snapshot.data),
                  SizedBox(height: 15),
                  snapshot.data == null ? Text("") : _buildCouponForm(),
                  SizedBox(height: 15),
                  snapshot.data == null
                      ? Text("")
                      : _buildBasket(snapshot.data),
                  SizedBox(height: 15),
                  snapshot.data == null
                      ? Text("")
                      : _buildCheckoutBtn(snapshot.data),
                ],
              ),
            );
          } else {
            return Text("Loading...");
          }
        },
      ),
    );
  }

  Widget _buildCheckoutBtn(Cart cart) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckOutScreen(cart: cart)));
        },
        style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
        child: Container(
          color: Styles.secondaryColor,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Thanh toán"),
          ),
        ));
  }

  Container _buildBasket(Cart cart) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giá giỏ hàng",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
                Text(
                  "${PriceUtil.toCurrency(cart.totalPrice())} VNĐ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giao hàng tiêu chuẩn",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
                Text(
                  "Miễn phí",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giảm giá",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.red,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
                Text(
                  "${PriceUtil.toCurrency(cart.totalDiscount())} VNĐ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.red,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
                Text(
                  "${PriceUtil.toCurrency(cart.totalPrice() - cart.totalDiscount())} VNĐ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCouponForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: _buildCouponTf(),
            ),
            SizedBox(width: 40),
            Expanded(
              flex: 2,
              child: _buildCouponBtn(),
            ),
          ],
        ),
      ),
    );
  }

  TextButton _buildCouponBtn() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Áp dụng",
        style: TextStyle(color: Colors.grey),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
    );
  }

  TextFormField _buildCouponTf() {
    return TextFormField(
      onSaved: (value) => _coupon = value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelText: "Mã giảm giá",
        labelStyle: TextStyle(color: Styles.secondaryColor),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.green),
        ),
      ),
    );
  }

  Future<Cart> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cart cart = Cart.fromJson(json.decode(prefs.getString("cart")));
    return cart;
  }

  String _getDisplay(Product product) {
    for (int i = 0; i < product.images.length; i++) {
      if (product.images[i].display == 1) return product.images[i].url;
    }
    return null;
  }

  Container _buildItems(Cart cart) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      child: Column(
        children: List.generate(cart.cartItems.length, (index) {
          return Container(
            height: 120,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: SizedBox(
                      width: 130,
                      height: 90,
                      child: Image(
                        image: NetworkImage(_getDisplay(
                            cart.cartItems[index].inventory.product)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                            "${cart.cartItems[index].inventory.product.name}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Size: ${cart.cartItems[index].inventory.size.size}"),
                                Text(
                                  "Có sẵn",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Styles.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${PriceUtil.toCurrency(cart.cartItems[index].inventory.product.price)} VNĐ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child:
                            IconButton(icon: Icon(Icons.add), onPressed: () {}),
                      ),
                      Text("${cart.cartItems[index].quantity}"),
                      Expanded(
                        child: IconButton(
                            icon: Icon(Icons.remove), onPressed: () {}),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
