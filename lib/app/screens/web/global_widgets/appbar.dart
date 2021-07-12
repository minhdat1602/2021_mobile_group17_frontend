import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/dj_module/notifications_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shopping_cart_module/shopping-cart_controller.dart';
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
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.find<NotificationController>()
                  .showNotification(new RemoteMessage(
                      notification: RemoteNotification(
                title: "AAA",
                body: "BBBB",
              )));
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
