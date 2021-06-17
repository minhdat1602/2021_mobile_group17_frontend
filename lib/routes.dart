// We use name route
// All our routes will be available here
import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/models/order_detail.dart';
import 'package:mobile_nhom17_2021/screens/web/change_password.dart';
import 'package:mobile_nhom17_2021/screens/web/checkout_info.dart';
import 'package:mobile_nhom17_2021/screens/web/home_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/login_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/menu_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/my_details.dart';
import 'package:mobile_nhom17_2021/screens/web/order.dart';
import 'package:mobile_nhom17_2021/screens/web/order_detail.dart';
import 'package:mobile_nhom17_2021/screens/web/register_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/shop_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/shopping_cart_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/account_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/bottom_nav_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/whishlist/whishlist_screen.dart';

final Map<String, WidgetBuilder> routes = {
  WhishlistScreen.routeName: (context) => WhishlistScreen(),
  BottomNavScreen.routeName: (context) => BottomNavScreen(),
  AccountScreen.routeName: (context) => AccountScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  CheckOutScreen.routeName: (context) => CheckOutScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  MenuScreen.routeName: (context) => MenuScreen(),
  MyDetailsScreen.routeName: (context) => MyDetailsScreen(),
  OrderDetailScreen.routeName: (context) => OrderDetailScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  ShopScreen.routeName: (context) => ShopScreen(),
  ShoppingCartScreen.routeName: (context) => ShoppingCartScreen(),
};
