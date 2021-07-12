import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/core/theme/pallete.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_product_module/widgets/description_widget.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_review_module/review_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shopping_cart_module/shopping-cart_controller.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:mobile_nhom17_2021/app/screens/web/global_widgets/appbar.dart';

import 'widgets/delivery_widget.dart';
import 'widgets/overview_widget.dart';
import 'widgets/returns_widget.dart';
import 'widgets/size_guide_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  ProductDetailScreen({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentIndex;
  ShoppingCartController shoppingCartController =
      Get.find<ShoppingCartController>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  Product product = Get.find<ShopController>().product.value;
  @override
  Widget build(BuildContext context) {
    List<Widget> _bodyWidget = [
      OverviewWidget(product: product),
      DescriptionWidget(product: product),
      ReviewScreen(),
      SizeGuideWidget(),
      // DeliveryWidget(),
      ReturnsWidget(),
    ];
    return Scaffold(
      appBar: AppBarWidget(title: "Sản phẩm"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(_buildSizeBSheet(product));
        },
        child: Icon(Icons.add_shopping_cart_sharp),
        backgroundColor: Get.theme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: 5,
              child: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: Material(
                  color: Colors.black,
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text(
                          "Tổng quan",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Tab(child: Text("Mô tả", style: TextStyle(fontSize: 16))),
                      Tab(
                          child:
                              Text("Đánh giá", style: TextStyle(fontSize: 16))),
                      Tab(
                          child: Text("Chọn kích cỡ",
                              style: TextStyle(fontSize: 16))),
                      // Tab(
                      //     child: Text("Vận chuyển",
                      //         style: TextStyle(fontSize: 16))),
                      Tab(
                          child:
                              Text("Đổi trả", style: TextStyle(fontSize: 16))),
                    ],
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            _bodyWidget[_currentIndex],
          ],
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
                shoppingCartController.saveProductToCart(
                    product.inventories[index], product);
                Get.bottomSheet(buildSCartQuickBSheet());
                // .then(
                //   (value) => Get.bottomSheet(
                //     buildSCartQuickBSheet(),
                //   ),
                // );
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
}
