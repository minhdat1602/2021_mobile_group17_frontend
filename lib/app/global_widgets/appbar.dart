import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/shop_controller.dart';

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
            onTap: () {},
            child: Icon(
              Icons.search,
              size: 30,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Get.toNamed("/shopping-cart");
            },
            child: Badge(
              badgeColor: Colors.transparent,
              position: BadgePosition.topEnd(top: 0),
              badgeContent: Obx(
                () => Text(
                  "${Get.find<ShopController>().cart.value.cartItems.length}",
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
