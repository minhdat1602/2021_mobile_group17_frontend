import 'dart:convert';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/shopping-cart_controller.dart';
import 'package:mobile_nhom17_2021/app/core/theme/pallete.dart';
import 'package:mobile_nhom17_2021/app/models/cart.dart';
import 'package:mobile_nhom17_2021/app/models/cart_item.dart';
import 'package:mobile_nhom17_2021/app/models/inventory.dart';
import 'package:mobile_nhom17_2021/app/models/product.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:mobile_nhom17_2021/app/controllers/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:mobile_nhom17_2021/app/screens/web/global_widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/screens/web/shop_screen/endrawer.dart';
import 'package:mobile_nhom17_2021/app/utils/price_toVnd.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({Key key}) : super(key: key);
  @override
  ShopScreenState createState() => ShopScreenState();
}

class ShopScreenState extends State<ShopScreen> {
  ShopController shopController = Get.put(ShopController());
  ShoppingCartController shoppingCartController =
      Get.put(ShoppingCartController());
  final shopKey = GlobalKey<ScaffoldState>();
  var rowNum;
  @override
  void initState() {
    super.initState();
    rowNum = 2;
  }

  @override
  void reassemble() {
    super.reassemble();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: shopKey,
      floatingActionButton: _filterFloatBtn(),
      endDrawer: EndDrawerWidget(),
      appBar: AppBarWidget(title: "Cửa hàng"),
      body: Column(
        children: [
          Expanded(
            child: _buildHeader(),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
              child: _buildItems(),
            ),
            flex: 12,
          ),
        ],
      ),
    );
  }

  FloatingActionButton _filterFloatBtn() {
    return FloatingActionButton(
      onPressed: () {
        shopKey.currentState.openEndDrawer();
      },
      child: const Icon(Icons.filter_list_outlined),
      // backgroundColor: Styles.secondaryColor,
    );
  }

  Container _buildHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Tất cả",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Obx(() => Text(
                      "${shopController.total.value} sản phẩm",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                flex: 1,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.grid_view,
                    size: 35.0,
                    color: rowNum == 2 ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      rowNum = 2;
                    });
                  }),
              IconButton(
                icon: Icon(
                  Icons.view_agenda_outlined,
                  size: 35.0,
                  color: rowNum == 1 ? Colors.black : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    rowNum = 1;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItems() {
    return Obx(() => FutureBuilder<List<Product>>(
          future: shopController.products.value,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowNum,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: Get.width * 0.02,
                  crossAxisSpacing: Get.width * 0.02,
                ),
                itemBuilder: (context, index) =>
                    _buildItem(snapshot.data[index]),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Có gì đó sai sai"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget _buildItem(Product product) {
    return Material(
      child: InkWell(
        onTap: () {
          shopController.addRecentlyViewed(product);
          shopController.product.value = product;
          Get.toNamed(Routes.PRODUCT);
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_getDisplay(product)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                flex: 10,
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              _buildProductPrice(product),
              SizedBox(height: 10),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(_buildSizeBSheet(product));
                    },
                    child: Text(
                      "MUA NHANH",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  // SizedBox(width: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSizeBSheet(Product product) {
    return Container(
      color: Pallete.primaryColor,
      height: 300,
      width: 350,
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Wrap(
        spacing: 5,
        direction: Axis.horizontal,
        runSpacing: 5,
        children: List.generate(
          product.inventories.length,
          (index) => SizedBox(
            width: 65,
            height: 65,
            child: TextButton(
              onPressed: () {
                Get.back();
                //save to cart
                shoppingCartController.saveProductToCart(
                    product.inventories[index], product);
                //show list item of cart
                Get.bottomSheet(buildSCartQuickBSheet());
              },
              child: Text(
                product.inventories[index].size.size,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Pallete.primaryColor,
                  side: BorderSide(
                    width: 1,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSCartQuickBSheet() {
    return Obx(() => SingleChildScrollView(
          child: Container(
            width: Get.width,
            color: Colors.white,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  child: TextButton(
                    onPressed: () {
                      print("thanh toán snackbar");
                      Get.back();
                      Get.toNamed(Routes.SHOPPING_CART);
                    },
                    child: Text("Thanh toán"),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      primary: Colors.white,
                      backgroundColor: Pallete.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                      "Tổng giá: ${PriceUtil.toCurrency(shoppingCartController.cart.value.totalPrice())} đ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                ),
                Divider(),
                Column(
                  children: List.generate(
                    shoppingCartController.cart.value.cartItems.length,
                    (index) => Container(
                      height: 120,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 130,
                              height: 90,
                              child: Image(
                                image: NetworkImage(_getDisplay(
                                    shoppingCartController.cart.value
                                        .cartItems[index].inventory.product)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                    shoppingCartController
                                        .cart
                                        .value
                                        .cartItems[index]
                                        .inventory
                                        .product
                                        .name,
                                    style: TextStyle(color: Colors.black)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Size: ${shoppingCartController.cart.value.cartItems[index].inventory.size.size}",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        Text(
                                          "Còn lại",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Get.theme.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        "${PriceUtil.toCurrency(shoppingCartController.cart.value.cartItems[index].inventory.product.price)} đ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${shoppingCartController.cart.value.cartItems[index].quantity}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String _getDisplay(Product product) {
    for (int i = 0; i < product.images.length; i++) {
      if (product.images[i].display == 1) return product.images[i].url;
    }
    return null;
  }

  Widget _buildProductPrice(Product product) {
    if (product.discount <= 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          "${PriceUtil.toCurrency(product.price)} đ",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      );
    } else {
      return Row(
        children: [
          SizedBox(width: 5),
          Text(
            "${PriceUtil.toCurrency(product.price)} đ",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.lineThrough,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 5),
          Text(
            "${PriceUtil.toCurrency(product.price - product.discount)} đ",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
        ],
      );
    }
  }
}
