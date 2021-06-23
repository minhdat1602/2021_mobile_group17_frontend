part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';

  //auth
  static const ROOT = '/root';
  static const ACCOUNT = '/account';
  static const REGISTER = '/register';
  static const ACCOUNT_DETIAL = '/account-detail';
  static const CHANGE_PW = '/change-password';

  static const BOTTOM_NAV = '/bottom-nav';

  static const HOME = '/home';
  static const MENU = '/menu';
  static const WHISHLIST = '/whishlist';
  static const LOGIN = '/login';

  static const CHECKOUT = '/checkout';
  static const ORDER = '/order';
  static const ORDER_DETAIL = '/order-detail';
  static const PRODUCT_SIZE = '/product_size';
  static const PRODUCT = '/product';
  static const SHOP = '/shop';
  static const SHOPPING_CART = '/shopping-cart';

  static const ADMIN_HOME = '/admin/home';
  static const ADMIN_LIST_PRODUCT = '/admin/list-product';
  static const ADMIN_LIST_ORDER = '/admin/list-order';
  static const ADMIN_ORDER_DETAIL = '/admin/order-detail';
}
