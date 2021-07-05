import 'package:mobile_nhom17_2021/app/models/product.dart';

class ProjectUtil {
  static String getDisplay(Product product) {
    for (int i = 0; i < product.images.length; i++) {
      if (product.images[i].display == 1) return product.images[i].url;
    }
    return "";
  }
}
