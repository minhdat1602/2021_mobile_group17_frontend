import 'package:mobile_nhom17_2021/app/data/models/inventory.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';

class ProjectUtil {
  static String getStock(Product product) {
    int sum = 0;
    if (product.inventories != null)
      for (Inventory inv in product.inventories) {
        sum += inv.quantity;
      }
    return sum.toString();
  }

  static String getDisplay(Product product) {
    for (int i = 0; i < product.images.length; i++) {
      if (product.images[i].display == 1) return product.images[i].url;
    }
    return "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png";
  }

  static String getRatingStr(int rate) {
    switch (rate) {
      case 0:
        return "Vui lòng đánh giá";
        break;
      case 1:
        return "Rất không hài lòng";
        break;
      case 2:
        return "Không hài lòng";
        break;
      case 3:
        return "Tạm ổn";
        break;
      case 4:
        return "Hài lòng";
        break;
      case 5:
        return "Rất hài lòng";
        break;
      default:
        return "";
    }
  }
}
