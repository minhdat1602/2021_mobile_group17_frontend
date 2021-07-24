part of './app_pages.dart';

abstract class Routes {
  // Logo
  static const INITIAL = '/dj';

  // Khởi tạo bottom nav bar cho 4 các màng hình chính.
  static const BOTTOM_NAV = '/bottom-nav';

  // TRANG CHỦ phía người dùng, item thứ 1 trong bottom nav bar
  static const HOME = '/home';

  // Trang DANH MỤC phía người dùng, item thứ 2...
  static const MENU = '/menu';

  // Trang DSách SPhẩm YÊU THÍCH của người dùng, item thứ 3...
  static const WHISHLISH = '/whishlist';

  // Trang điều hướng Trang QUẢN LÍ TÀI KHOẢN || ĐĂNG NHẬP cho user, item thứ 4///
  static const ROOT = '/root';
  static const ACCOUNT = '/account';
  static const LOGIN = '/login';

  static const REGISTER = '/register';
  static const ACCOUNT_DETIAL = '/account-detail';
  static const CHANGE_PASSWORD = '/change-password';
  static const FORGOT_PASSWORD = '/forgot-password';

  // Trang trưng bài sản phẩm của cửa hàng
  static const SHOP = '/shop';
  static const PRODUCT = '/product';
  static const CHECKOUT = '/checkout';
  static const ORDER = '/order';
  static const SHOPPING_CART = '/shopping-cart';

  // Danh sách đánh giá và đánh giá sản phẩm
  static const REVIEW = '/reivew';
  static const RATING = "/rating";

  static const MY_ORDERS = '/my-orders';
  static const MY_ORDER_DETAIL = '/my-order-detail';
  static const PRODUCT_SIZE = '/product_size';

  static const CONNECTIVITY = '/connectivity';

  static const ADMIN_DASHBOARD = '/admin/home';
  static const ADMIN_LIST_ORDER = '/admin/list-order';
  static const ADMIN_ORDER_DETAIL = '/admin/order-detail';
  static const ADMIN_LIST_PRODUCT = "/admin/list_product";
  static const ADMIN_NOTIFICATION = "/admin/notification";
  static const ADMIN_ADD_PRODUCT = "/admin/product/add";
}
