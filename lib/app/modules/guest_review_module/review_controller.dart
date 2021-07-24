import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/review.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_product_module/product_controller.dart';
import 'package:mobile_nhom17_2021/app/data/services/review_api.dart';

class ReviewController extends GetxController {
  ReviewAPI reviewAPI = Get.put(ReviewAPI());

  var reviews = Future.value(<Review>[]).obs;
  RxDouble starAvg = 0.0.obs;
  var star5 = 0.obs;
  var star4 = 0.obs;
  var star3 = 0.obs;
  var star2 = 0.obs;
  var star1 = 0.obs;
  var totalReview = 0.obs;

  // Đánh giá sản phẩm

  AuthController authController = Get.put(AuthController());
  ProductController productController = Get.put(ProductController());
  Future<void> rating(Review review) async {
    review.user = authController.user;
    review.product = productController.product;
    if (review.product != null && review.user != null && review.rate != null) {
      Review response =
          await reviewAPI.rating(review); // Gửi đánh giá đến server
      if (response != null) {
        await reviews.value.then((value) =>
            value.add(response)); // Thêm đánh giá vừa đánh giá vào ds đánh giá
        // Trở về trang review
      } else {
        Get.snackbar(
          "Đánh giá thất bại",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
        );
      }
    } else
      print("Thiếu thông tin đánh giá");
  }

  @override
  void onInit() {
    super.onInit();
    // Lấy danh sách đánh giá của sản phẩm.
    if (productController.product != null)
      getReviews(productController.product.id);

    // set số lượng cho mỗi số sao và số sao trung bình cho tất cả đánh giá
    // star_5.value = 0;
    // star_4.value = 0;
    // star_3.value = 0;
    // star_2.value = 0;
    // star_1.value = 0;
    // starAvg.value = 0;

    reviews.value.then((value) {
      int starSum = 0;
      totalReview.value = value.length;
      for (Review review in value) {
        starSum += review.rate;
        int star = review.rate;
        switch (star) {
          case 5:
            star5.value++;
            break;
          case 4:
            star4.value++;
            break;
          case 3:
            star3.value++;
            break;
          case 2:
            star2.value++;
            break;
          case 1:
            star1.value++;
            break;
        }
      }
      starAvg.value = (starSum / value.length).toDouble();
    });
  }

  void getReviews(int productId) {
    reviews.value = reviewAPI.fetchReview(productId);
  }
}
