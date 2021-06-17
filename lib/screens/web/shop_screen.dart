import 'dart:convert';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_nhom17_2021/config/styles.dart';
import 'package:mobile_nhom17_2021/models/cart.dart';
import 'package:mobile_nhom17_2021/models/cart_item.dart';
import 'package:mobile_nhom17_2021/models/inventory.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/models/user.dart';
import 'package:mobile_nhom17_2021/screens/web/product/product_screen.dart';
import 'package:mobile_nhom17_2021/screens/web/shopping_cart_screen.dart';
import 'package:mobile_nhom17_2021/service/cart_service.dart';
import 'package:mobile_nhom17_2021/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/utils/clear_focus.dart';
import 'package:mobile_nhom17_2021/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopScreen extends StatefulWidget {
  static String routeName = "/shop";
  final Future<List<Product>> fetchProduct;

  ShopScreen({Key key, this.fetchProduct}) : super(key: key);
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final _blurNode = FocusNode();
  String typeRow = "gridview";
  String dropdownValue = "One";
  String productStrNum;
  int productNum;
  bool showSnackBar;
  final GlobalKey<ScaffoldState> _shopKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // futureproduct = fetchProduct();
    productNum = 0;
    productStrNum = "Đang tải...";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _shopKey,
      floatingActionButton: _filterFloatBtn(),
      endDrawer: Drawer(
        child: ListView(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                color: Colors.black,
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_downward,
                color: Colors.green,
              ),
              iconSize: 24,
              underline: SizedBox(),
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      appBar: AppBarWidget(title: "Cửa hàng"),
      body: ClearFocus(
        child: Column(
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
      ),
    );
  }

  FloatingActionButton _filterFloatBtn() {
    return FloatingActionButton(
      onPressed: () {
        _shopKey.currentState.openEndDrawer();
      },
      child: const Icon(Icons.filter_list_outlined),
      backgroundColor: Styles.secondaryColor,
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
                child: Text(
                  "$productStrNum",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    color: (typeRow == "gridview") ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      typeRow = "gridview";
                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.view_agenda_outlined,
                    size: 35.0,
                    color: typeRow == "listview" ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      typeRow = "listview";
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }

  void setNum(int num) {
    setState(() {
      productStrNum = "$num tìm thấy";
    });
  }

  Widget _buildItems() {
    return FutureBuilder(
        future: widget.fetchProduct,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            productNum = snapshot.data.length;
            productStrNum = "$productNum sản phẩm";
            return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount(typeRow),
                childAspectRatio: 0.65,
                mainAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
              ),
              itemBuilder: (context, index) => _buildItem(snapshot.data[index]),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return SpinKitPouringHourglass(
              color: Colors.black,
              size: 100,
            );
          }
        });
  }

  int _crossAxisCount(String type) {
    if (type == "gridview") {
      if (MediaQuery.of(context).size.width < 480) {
        return 2;
      } else if (MediaQuery.of(context).size.width < 768) {
        return 3;
      } else {
        return 4;
      }
    } else if (type == "listview") {
      return 1;
    } else {
      return 2;
    }
  }

  GlobalKey _dialogKey = GlobalKey();

  final oCcy = new NumberFormat("#,###", "en_US");
  Widget _buildItem(Product product) {
    return Material(
      child: InkWell(
        onTap: () {
          addRecentlyViewed(
              product); //ktra đã có trong ds đã xem, nếu chưa thì thêm vào
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product)));
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
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
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
                  // SizedBox(width: 2),
                  TextButton(
                    onPressed: () {
                      showFlash(
                        context: context,
                        persistent: true,
                        builder: (_, controller) {
                          return Flash.dialog(
                            key: _dialogKey,
                            onTap: () {
                              controller.dismiss();
                            },
                            controller: controller,
                            backgroundColor: Colors.white,
                            alignment: Alignment.center,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              color: Styles.secondaryColor,
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
                                        _saveCartItem(
                                            product.inventories[index],
                                            product,
                                            controller);
                                        _buildSnackBar();
                                      },
                                      child: Text(
                                        product.inventories[index].size.size,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              Styles.secondaryColor,
                                          side: BorderSide(
                                            width: 1,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
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
                    onPressed: () {
                      _buildSnackBar();
                    },
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

  String _getDisplay(Product product) {
    for (int i = 0; i < product.images.length; i++) {
      if (product.images[i].display == 1) return product.images[i].url;
    }
    return null;
  }

  void _saveCartItem(
      Inventory inventory, Product product, FlashController controller) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cart cart;
    CartItem cartItem;
    String cartJson = prefs.get("cart");
    if (cartJson != null) cart = Cart.fromJson(json.decode(cartJson));
    inventory.product = product;
    if (cart == null) {
      cart = new Cart();
      cartItem = new CartItem(inventory: inventory, quantity: 1);
      List<CartItem> cartItems = [];
      cartItems.add(cartItem);
      cart.cartItems = cartItems;
      try {
        prefs.setString("cart", json.encode(cart.toJson()));
      } catch (e) {
        print("ERROR$e");
      }

      print(cartItems.length);
    } else {
      cartItem = new CartItem(inventory: inventory, quantity: 1);

      List<CartItem> cartItems = cart.cartItems;
      if (cartItems == null) cartItems = [];
      bool contains = false;
      int size = cartItems.length;
      for (int i = 0; i < size; i++) {
        if (cartItems[i].inventory.id == cartItem.inventory.id) {
          contains = true;
          cartItems[i].quantity = cartItems[i].quantity + 1;
        }
        if (!contains) {
          cartItems.add(cartItem);
          contains = true;
        }
        cart.cartItems = cartItems;
        if (prefs.getString("user") != null) {
          User user = User.fromJson(json.decode(prefs.getString("user")));
          cart.user = user;
          saveCart(cart);
        } else {
          prefs.setString("cart", json.encode(cart.toJson()));
        }
      }
    }
    print(json.encode(cart.toJson()));
    controller.dismiss();
  }

  Future<Cart> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cart cart = Cart.fromJson(json.decode(prefs.getString("cart")));
    return cart;
  }

  Widget _buildSnackBarItem(Cart cart) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  print("thanh toán snackbar");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCartScreen()));
                },
                child: Text("Thanh toán"),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  primary: Colors.white,
                  backgroundColor: Styles.secondaryColor,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                  "Tổng giá: ${PriceUtil.toCurrency(cart.totalPrice())} VNĐ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            ),
            Divider(),
            Column(
              children: List.generate(
                cart.cartItems.length,
                (index) => Container(
                  height: 120,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                                cart.cartItems[index].inventory.product.name,
                                style: TextStyle(color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Size: ${cart.cartItems[index].inventory.size.size}",
                                        style: TextStyle(color: Colors.black)),
                                    Text(
                                      "Còn lại",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Styles.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    "${PriceUtil.toCurrency(cart.cartItems[index].inventory.product.price)} VNĐ",
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
                            "${cart.cartItems[index].quantity}",
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
    );
  }

  void _buildSnackBar() {
    _shopKey.currentState.showSnackBar(
      SnackBar(
        content: FutureBuilder(
          future: getCart(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildSnackBarItem(snapshot.data);
            } else {
              return Text("Loading...");
            }
          },
        ),
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(hours: 1),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildProductPrice(Product product) {
    if (product.discount <= 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          "${oCcy.format(product.price)} VNĐ",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      );
    } else {
      return Row(
        children: [
          SizedBox(width: 5),
          Text(
            "${PriceUtil.toCurrency(product.price)}",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(width: 5),
          Text(
            "${PriceUtil.toCurrency(product.price - product.discount)} VNĐ",
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

  void addRecentlyViewed(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isStored = false;
    String productJson = json.encode(product.toJson());
    print(productJson);
    List<String> recentlyVieweds = prefs.getStringList("recentlyViewed");
    if (recentlyVieweds == null) {
      recentlyVieweds = [];
      recentlyVieweds.add(productJson);
    } else if (recentlyVieweds.length >= 6) {
      recentlyVieweds.removeAt(0);
    } else {
      for (int i = 0; i < recentlyVieweds.length; i++) {
        if (recentlyVieweds[i] == productJson) {
          isStored = true;
        }
      }
      if (!isStored) {
        recentlyVieweds.add(productJson);
      }
    }
    prefs.setStringList("recentlyViewed", recentlyVieweds);
  }
}
