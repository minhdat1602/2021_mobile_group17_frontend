import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/models/order_detail.dart';
import 'package:mobile_nhom17_2021/screens/account_screen.dart';
import 'package:mobile_nhom17_2021/screens/change_password.dart';
import 'package:mobile_nhom17_2021/screens/checkout_info.dart';

import 'package:mobile_nhom17_2021/screens/home_screen.dart';
import 'package:mobile_nhom17_2021/screens/login_screen.dart';
import 'package:mobile_nhom17_2021/screens/menu_screen.dart';
import 'package:mobile_nhom17_2021/screens/my_details.dart';
import 'package:mobile_nhom17_2021/screens/order.dart';
import 'package:mobile_nhom17_2021/screens/order_detail.dart';
import 'package:mobile_nhom17_2021/screens/register_screen.dart';

import 'package:mobile_nhom17_2021/screens/whishlist_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);

    super.initState();
  }

  // final List _screen = [
  // HomeScreen(),
  //   MenuScreen(),
  //   ShopScreen(),
  //   WhishlistScreen(),
  //   LoginScreen(),
  // ];
  // int _currentIndex = 0;
  // final List _label = ["Trang chủ", "Cửa hàng", "Yêu thích", "Tài khoản"];

  // @override
  // Widget build(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          inactiveIcon: Icon(Icons.home_outlined),
          title: ("Trang chủ"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.shop_two),
          inactiveIcon: Icon(Icons.shop_two_outlined),
          title: ("Cửa hàng"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.favorite),
          inactiveIcon: Icon(Icons.favorite_outline),
          title: ("Yêu thích"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          inactiveIcon: Icon(Icons.person_outline),
          title: ("Tài khoản"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    List<Widget> _buildScreens() {
      return [
        // OrderScreen(),
        // OrderDetailScreen(),
        HomeScreen(),
        // CheckOutScreen(),
        // RegisterScreen(),
        MenuScreen(_controller),
        // MyDetailsScreen(),
        // ChangePasswordScreen(),
        WhishlistScreen(),
        AccountScreen(),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.black, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: Colors.black,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 100),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
  // return Scaffold(
  //   body: _screen[_currentIndex],
  //   bottomNavigationBar: BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     onTap: (index) => setState(() => _currentIndex = index),
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.black,
  //     showSelectedLabels: false,
  //     showUnselectedLabels: false,
  //     selectedItemColor: Colors.white,
  //     unselectedItemColor: Colors.grey,
  //     items: [
  //       _currentIndex == 0 ? Icons.home : Icons.home_outlined,
  //       _currentIndex == 1 ? Icons.shop_two : Icons.shop_two_outlined,
  //       _currentIndex == 2 ? Icons.favorite : Icons.favorite_outline,
  //       _currentIndex == 3 ? Icons.person : Icons.person_outline,
  //     ]
  //         .asMap()
  //         .map(
  //           (key, value) => MapEntry(
  //             key,
  //             BottomNavigationBarItem(
  //               label: _label[key],
  //               icon: Container(
  //                 child: Column(
  //                   children: [
  //                     Icon(value),
  //                     Text(
  //                       _label[key],
  //                       style: TextStyle(
  //                           color: key == _currentIndex
  //                               ? Colors.white
  //                               : Colors.grey),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )
  //         .values
  //         .toList(),
  //   ),
  // );

}
