import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/root_util.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_bottom_nav_module/bottom_nav_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_home_module/home_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_menu_module/menu_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_whishlist_module/whishlist_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavScreen extends GetWidget<BottomNavController> {
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
        HomeScreen(),
        MenuScreen(),
        WhishlistScreen(),
        Root(),
      ];
    }

    return Obx(() => PersistentTabView(
          context,
          controller: controller.ptController,
          screens: _buildScreens(),
          items: _navBarsItems(),
          backgroundColor: Colors.black, // Default is Colors.white.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
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
            duration: Duration(milliseconds: 400),
          ),
          navBarStyle: NavBarStyle
              .style6, // Choose the nav bar style with this property.
        ));
  }
}
