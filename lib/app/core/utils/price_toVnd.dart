import 'package:intl/intl.dart';

class PriceUtil {
  static String toCurrency(double price) {
    final oCcy = new NumberFormat("#,###", "en_US");
    return oCcy.format(price);
  }
}
