import 'package:mobile_nhom17_2021/app/data/models/cart_item.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  int id;
  UserModel user;
  List<CartItem> cartItems;
  Cart({this.id, this.user, this.cartItems});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);

  double totalPrice() {
    double sum = 0;
    if (cartItems != null) {
      for (int i = 0; i < cartItems.length; i++) {
        sum += cartItems[i].quantity * cartItems[i].inventory.product.price;
      }
    }
    return sum;
  }

  double totalDiscount() {
    double sum = 0;
    if (cartItems != null) {
      for (int i = 0; i < cartItems.length; i++) {
        sum += cartItems[i].quantity * cartItems[i].inventory.product.discount;
      }
    }
    return sum;
  }
}
