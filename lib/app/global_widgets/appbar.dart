import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shopping_cart_module/shopping-cart_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/notification_module/notifications_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/search_module/search_screen.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  final String title;
  const AppBarWidget({Key key, this.title}) : super(key: key);
  @override
  AppBarWidgetState createState() => AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarWidgetState extends State<AppBarWidget> {
  ShoppingCartController shoppingCartController =
      Get.put(ShoppingCartController());
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(
                SearchScreen(),
                transition: Transition.rightToLeft,
                curve: Curves.linear,
              );
              // Scaffold.of(context).openEndDrawer();
              // Get.find<NotificationController>()
              //     .showNotification(new RemoteMessage(
              //         notification: RemoteNotification(
              //   title: "AAA",
              //   body: "BBBB",
              // )));
            },
            child: Icon(
              Icons.search,
              size: 30,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.SHOPPING_CART);
            },
            child: Badge(
              badgeColor: Colors.transparent,
              position: BadgePosition.topEnd(top: 0),
              badgeContent: Obx(
                () => Text(
                  "${shoppingCartController.cart.value.cartItems.length}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
