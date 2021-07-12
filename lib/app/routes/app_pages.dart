import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_categories_module/list_product_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_transaction_mobule/list_order_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_transaction_mobule/order_detail_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/account_detail_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/login_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/register_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/root_util.dart';
import 'package:mobile_nhom17_2021/app/modules/connectivity_module/notification_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/connectivity_module/notification_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/dj_module/dj_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_bottom_nav_module/bottom_nav_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_checkout_module/checkout_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_checkout_module/checkout_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_home_module/user_home_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_menu_module/menu_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/my_order_detail_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/my_orders_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_product_module/product_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_review_module/review_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/change_password.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_rating_module/rating_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_whishlist_module/whishlist_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_whishlist_module/wishlist_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/admin_home_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_review_module/review_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_rating_module/rating_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_bottom_nav_module/bottom_nav_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_home_module/home_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_menu_module/menu_screen.dart';

import 'package:mobile_nhom17_2021/app/modules/guest_shopping_cart_module/shopping_cart_screen.dart';
import 'package:mobile_nhom17_2021/app/modules/notification_module/connectivity_binding.dart';
import 'package:mobile_nhom17_2021/app/modules/notification_module/connectivity_screen.dart';
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
    GetPage(
        name: Routes.ACCOUNT_DETIAL,
        page: () => MyDetailsScreen(),
        binding: AuthBinding()),
    GetPage(
      name: Routes.USER_LOGIN,
      page: () => LoginScreen(),
    ),

    GetPage(
      name: Routes.USER_REVIEW,
      page: () => ReviewScreen(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: Routes.USER_RATING,
      page: () => RatingScreen(),
      binding: RatingBinding(),
    ),

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

    // GetPage(
    //   name: Routes.ORDER,
    //   page: () => OrderScreen(),
    // ),

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
