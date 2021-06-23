import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart_item.dart';
import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/models/order_detail.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/app/data/models/status.dart';
import 'dart:convert';

import 'package:mobile_nhom17_2021/app/data/models/user.dart';

class CheckoutAPI {
  Future<Order> checkout(Cart cart, User user) async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/order");

    List<OrderDetail> orderDetails = [];
    for (CartItem cartItem in cart.cartItems) {
      orderDetails.add(new OrderDetail(
        discount: cartItem.inventory.product.discount,
        product: cartItem.inventory.product,
        price: cartItem.inventory.product.price,
        quantity: cartItem.quantity,
      ));
    }

    Order order;
    order = new Order(
      totalDiscount: cart.totalDiscount(),
      totalSellPrice: cart.totalPrice(),
      totalMoney: cart.totalPrice() - cart.totalDiscount(),
      user: user,
      status: Status(id: 1),
    );
    order.orderDetails = orderDetails;

    String bodys = json.encode(order.toJson());
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(url, headers: headers, body: bodys);
    if (response.statusCode == 200) {
      try {
        order = Order.fromJson(json.decode(response.body));
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    return order;
  }
}
