import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/auth_binding.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/checkout_binding.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/connectivity_binding.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/notification_binding.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/user_home_binding.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/wishlist_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/account_module/change_password.dart';
import 'package:mobile_nhom17_2021/app/screens/admin/admin_transactions_screen/list_order_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/admin/admin_transactions_screen/order_detail_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/connectivity_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/dj_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/account_detail_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_categories.dart/list_product_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/admin/admin_home_screen/admin_home_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/login_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/orders/my_orders_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/product_screen/product_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/register_screen.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/bottom_nav_binding.dart';
import 'package:mobile_nhom17_2021/app/screens/web/bottom_nav_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/checkout_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/home_screen.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/menu_binding.dart';
import 'package:mobile_nhom17_2021/app/screens/web/menu_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/order_module/order.dart';
import 'package:mobile_nhom17_2021/app/screens/web/orders/my_order_detail_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/admin/notification_screen.dart';
import 'package:mobile_nhom17_2021/app/controllers/bindings/shop_binding.dart';
import 'package:mobile_nhom17_2021/app/screens/web/shop_screen/shop_screen.dart';

import 'package:mobile_nhom17_2021/app/screens/web/shopping_cart_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/whishlist_module/whishlist_screen.dart';
import 'package:mobile_nhom17_2021/app/screens/web/root_util.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.GLOBAL_DJ,
      page: () => DJScreen(),
      bindings: [
        NotificationBinding(),
        ConnectivityBinding(),
      ],
    ),
    GetPage(
      name: Routes.INITIAL,
      page: () => BottomNavScreen(),
      bindings: [
        BottomNavBinding(),
      ],
    ),
    GetPage(
      name: Routes.USER_HOME,
      page: () => HomeScreen(),
      binding: UserHomeBinding(),
    ),
    GetPage(
      name: Routes.USER_MENU,
      page: () => MenuScreen(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: Routes.USER_WHISHLIST,
      page: () => WhishlistScreen(),
      binding: WhishListBinding(),
    ),
    GetPage(
      name: Routes.USER_ROOT,
      page: () => Root(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.USER_SHOP,
      page: () => ShopScreen(),
      binding: ShopBinding(),
    ),
    // GetPage(
    //     name: Routes.ACCOUNT_DETIAL,
    //     page: () => MyDetailsScreen(),
    //     binding: AuthBinding()),
    // GetPage(
    //   name: Routes.USER_LOGIN,
    //   page: () => LoginScreen(),
    // ),

    // DS đơn hàng, chi tết đơn hàng của người dùng.
    GetPage(
      name: Routes.MY_ORDERS,
      page: () => MyOrdersScreen(),
    ),
    GetPage(
      name: Routes.MY_ORDER_DETAIL,
      page: () => MyOrderDetailScreen(),
    ),
    //login and account

    // register
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: Routes.BOTTOM_NAV,
      page: () => BottomNavScreen(),
      bindings: [
        AuthBinding(),
        BottomNavBinding(),
        MenuBinding(),
      ],
    ),

    GetPage(
      name: Routes.CHANGE_PW,
      page: () => ChangePasswordScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: Routes.SHOPPING_CART,
      page: () => ShoppingCartScreen(),
    ),

    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckOutScreen(),
      binding: CheckoutBinding(),
    ),

    GetPage(
      name: Routes.ORDER,
      page: () => OrderScreen(),
    ),

    GetPage(
      name: Routes.PRODUCT,
      page: () => ProductDetailScreen(),
      binding: ShopBinding(),
    ),

    //admin
    GetPage(
      name: Routes.ADMIN_HOME,
      page: () => AdminHomePage(),
    ),

    GetPage(
      name: Routes.ADMIN_LIST_PRODUCT,
      page: () => ListProductScreen(),
    ),
    GetPage(
      name: Routes.ADMIN_LIST_ORDER,
      page: () => ListOrderScreen(),
    ),
    GetPage(
      name: Routes.ADMIN_ORDER_DETAIL,
      page: () => OrderDetailAdminScreen(),
    ),
    GetPage(
      name: Routes.ADMIN_NOTIFICATION,
      page: () => NotificationScreen(),
    ),

    GetPage(
      name: Routes.CONNECTIVITY,
      page: () => ConnectivityScreen(),
    ),
  ];
}
