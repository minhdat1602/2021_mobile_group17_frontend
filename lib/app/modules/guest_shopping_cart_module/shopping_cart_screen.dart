// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/coupon.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shopping_cart_module/shopping-cart_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartScreen extends StatefulWidget {
  static String routeName = "/shopping-cart";
  ShoppingCartScreen();
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  String _coupon;
  ShoppingCartController shoppingCartController =
      Get.find<ShoppingCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "Giỏ hàng",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
              GlobalKey<ShopScreenState>().currentState.setState(() {});
            }),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            shoppingCartController.cart.value.cartItems.length == 0
                ? Text("Giỏ hàng rỗng", style: TextStyle(color: Colors.black))
                : Obx(() => _buildItems(shoppingCartController.cart.value)),
            SizedBox(height: 15),
            shoppingCartController.cart.value.cartItems.length == 0
                ? Text("")
                : _buildCouponForm(),
            SizedBox(height: 15),
            shoppingCartController.cart.value.cartItems.length == 0
                ? Text("")
                : Obx(() => _buildBasket(shoppingCartController.cart.value)),
            SizedBox(height: 15),
            shoppingCartController.cart.value.cartItems.length == 0
                ? Text("")
                : _buildCheckoutBtn(shoppingCartController.cart.value),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutBtn(Cart cart) {
    return ElevatedButton(
        onPressed: () {
          shoppingCartController.cart.value.cartItems.length > 0
              ? Get.toNamed(Routes.CHECKOUT)
              : Get.rawSnackbar(
                  message: "Không có sản phẩm nào trong giỏ hàng");
        },
        style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
        child: Container(
          color: Get.theme.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Thanh toán"),
          ),
        ));
  }

  Widget _buildBasket(Cart cart) {
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
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${PriceUtil.toCurrency(cart.totalPrice())} đ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 0.1,
                    color: Colors.black,
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
                    color: Colors.black,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                ),
                Obx(() => Text(
                      "${PriceUtil.toCurrency(shoppingCartController.getDiscount())} đ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: 0.1,
                      ),
                    )),
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
                  "Tạm tính",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.1,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${PriceUtil.toCurrency(shoppingCartController.getPrice())} đ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.1,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final _couponForm = GlobalKey<FormState>();

  Container _buildCouponForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      child: Column(
        children: [
          Row(
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
          Obx(
            () => Container(
              height: shoppingCartController.coupons.length * 40.0,
              child: ListView.builder(
                itemCount: shoppingCartController.coupons.length,
                itemBuilder: (context, index) {
                  return _buildCouponItem(
                      shoppingCartController.coupons[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildCouponItem(Coupon coupon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${coupon.code}",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: Text("Xóa mã giảm giá"),
                content: Text("Bạn muốn xóa mã giảm giá này"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.reset();
                    },
                    child: Text("Hủy"),
                  ),
                  TextButton(
                    onPressed: () {
                      shoppingCartController.coupons.remove(coupon);
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          },
          icon: Icon(
            Icons.remove,
          ),
        ),
      ],
    );
  }

  TextButton _buildCouponBtn() {
    return TextButton(
      onPressed: () {
        _couponForm.currentState.save();
        print(_couponForm.currentState.validate());
        if (_couponForm.currentState.validate()) {
          shoppingCartController.addCoupon(_coupon);
        }
      },
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

  Widget _buildCouponTf() {
    return Form(
      key: _couponForm,
      child: TextFormField(
        onSaved: (value) => _coupon = value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          labelText: "Mã giảm giá",
          labelStyle: TextStyle(color: Get.theme.primaryColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.green),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Mã giảm giá trống";
          }
          return null;
        },
      ),
    );
  }

  String _getDisplay(Product product) {
    for (int i = 0; i < product.images.length; i++) {
      if (product.images[i].display == 1) return product.images[i].url;
    }
    return null;
  }

  Widget _buildItems(Cart cart) {
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
                          "${cart.cartItems[index].inventory.product.name}",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
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
                                  "Size: ${cart.cartItems[index].inventory.size.size}",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Có sẵn",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Get.theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${PriceUtil.toCurrency(cart.cartItems[index].inventory.product.price)} đ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black,
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
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cart.cartItems[index].quantity++;
                              shoppingCartController.updateCart(cart);
                              setState(() {});
                            }),
                      ),
                      Text(
                        "${cart.cartItems[index].quantity}",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (cart.cartItems[index].quantity > 1)
                                cart.cartItems[index].quantity--;
                              else
                                cart.cartItems.remove(cart.cartItems[index]);
                              shoppingCartController.updateCart(cart);
                              setState(() {});
                            }),
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
