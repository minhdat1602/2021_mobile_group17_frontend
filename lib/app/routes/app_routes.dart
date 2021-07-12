part of './app_pages.dart';

abstract class Routes {
  // Logo
  static const GLOBAL_DJ = '/dj';

  // Khởi tạo bottom nav bar cho 4 các màng hình chính.
  static const INITIAL = '/';

  // TRANG CHỦ phía người dùng, item thứ 1 trong bottom nav bar
  static const USER_HOME = '/home';

  // Trang DANH MỤC phía người dùng, item thứ 2...
  static const USER_MENU = '/menu';

  // Trang DSách SPhẩm YÊU THÍCH của người dùng, item thứ 3...
  static const USER_WHISHLIST = '/whishlist';

  // Trang điều hướng Trang QUẢN LÍ TÀI KHOẢN || ĐĂNG NHẬP cho user, item thứ 4///
  static const USER_ROOT = '/root';
  static const USER_ACCOUNT = '/account';
  static const USER_LOGIN = '/login';

  // Trang trưng bài sản phẩm của cửa hàng
  static const USER_SHOP = '/shop';

  // Danh sách đánh giá và đánh giá sản phẩm
  static const USER_REVIEW = '/reivew';
  static const USER_RATING = "/rating";

  static const REGISTER = '/register';
  static const ACCOUNT_DETIAL = '/account-detail';
  static const CHANGE_PW = '/change-password';

  static const BOTTOM_NAV = '/bottom-nav';

  static const CHECKOUT = '/checkout';
  static const ORDER = '/order';

  static const MY_ORDERS = '/my-orders';
  static const MY_ORDER_DETAIL = '/my-order-detail';
  static const PRODUCT_SIZE = '/product_size';
  static const PRODUCT = '/product';

  static const SHOPPING_CART = '/shopping-cart';

  static const CONNECTIVITY = '/connectivity';

  static const ADMIN_HOME = '/admin/home';
  static const ADMIN_LIST_PRODUCT = '/admin/list-product';
  static const ADMIN_LIST_ORDER = '/admin/list-order';
  static const ADMIN_ORDER_DETAIL = '/admin/order-detail';

  static const ADMIN_NOTIFICATION = "/admin/notification";
}
