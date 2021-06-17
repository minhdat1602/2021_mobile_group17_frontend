import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/models/cart.dart';
import 'package:mobile_nhom17_2021/screens/web/shopping_cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  final String title;
  const AppBarWidget({Key key, this.title}) : super(key: key);
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark, // Màu icon giờ pin trên status bar
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShoppingCartScreen()));
          },
          child: Icon(
            Icons.search,
            size: 30,
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShoppingCartScreen()));
          },
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 30,
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Future<Cart> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cart cart = Cart.fromJson(json.decode(prefs.getString("cart")));
    return cart;
  }
}
