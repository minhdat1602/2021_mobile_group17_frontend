import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_product_module/product_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_review_module/review_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/image.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/models/review.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/data/services/review_api.dart';
import 'package:permission_handler/permission_handler.dart';

class RatingController extends GetxController {
  var pickedImages = <PickedFile>[].obs;
  Rx<int> rate = 0.obs;
  Rx<String> content = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Thực hiện đánh giá tới server
  AuthController authController = Get.put(AuthController());
  ProductController productController = Get.put(ProductController());
  ReviewController reviewController = Get.put(ReviewController());
  ReviewAPI reviewAPI = Get.put(ReviewAPI());
  Future rating() async {
    UserModel user = authController.user;
    Product product = productController.product;

    // Kiểm tra thông tin đánh giá
    if (rate > 0 && user.id > 0 && product.id > 0) {
      // upload hình ảnh và nhận danh sách image model
      List<ImageModel> images = await uploadImages();

      // Tạo Model review để gửi đến server
      Review review = new Review()
        ..rate = rate.value
        ..content = content.value
        ..images = images
        ..product = product
        ..user = user;

      // Thực hiện đánh giá
      review = await reviewAPI.rating(review);

      // Log
      review != null
          ? print("Đánh giá thành công")
          : print("Đánh giá thật bại");
      // Thêm đánh giá mới vào ds đánh giá của sp
      await reviewController.reviews.value.then((value) {
        value.assign(review);
        reviewController.update();
      });
    } else {
      print("Thông tin không hợp lệ");
    }
  }

  // Lấy hình ảnh từ Library hình ảnh
  Future getImage() async {
    final _picker = ImagePicker();
    List<PickedFile> pickedFiles = await _picker.getMultiImage();
    try {
      pickedImages.value = pickedFiles;
    } catch (e) {
      print("error: $e");
    }
  }

  /// Upload danh sách hình ảnh lấy từ image_picker(Galley) lên Firebase Storage
  /// và trả về danh sách Image(chứa url)
  Future<List<ImageModel>> uploadImages() async {
    List<ImageModel> imageUrls = [];
    File file;
    for (PickedFile pickedFile in pickedImages) {
      file = File(pickedFile.path);

      // Upload từng item và nhận về url của item đó trên firebase storage
      String url = await uploadImageItem(file);

      ImageModel imageUrl = new ImageModel(url: url);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  /// Upload item trong danh sách image
  Future<String> uploadImageItem(File file) async {
    final _storage = FirebaseStorage.instance;
    String filename = file.path;

    // Check permission
    var permission = await Permission.photos.status;
    if (permission.isGranted) print("isGranted");

    // upload lên folder comments/
    var snapshot =
        await _storage.ref().child("comments/$filename").putFile(file);

    // Lấy url của ảnh vừa upload
    var downloadUrl = await snapshot.ref.getDownloadURL();
    print("downloadUrl: $downloadUrl");
    return downloadUrl;
  }
}
