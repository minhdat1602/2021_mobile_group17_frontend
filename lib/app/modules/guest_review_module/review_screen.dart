import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_review_module/review_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/review.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  AuthController authController = Get.put(AuthController());
  ReviewController controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      init: ReviewController(),
      initState: (_) {},
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height - 150,
            child: FutureBuilder(
                future: controller.reviews.value,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView(
                      children: [
                        _buildRatingGeneral(snapshot.data),
                        _buildCommentItems(snapshot.data),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("FETCH ERROR"));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        );
      },
    );
  }

  Widget _buildCommentItems(List<Review> reviews) {
    return Column(
      children: List.generate(reviews.length == null ? 0 : reviews.length,
          (index) => _buildCommentItem(reviews[index])),
    );
  }

  Container _buildCommentItem(Review review) {
    return Container(
      padding: EdgeInsets.all(16),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1.5,
            color: Colors.grey[200],
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${review.user.userInfo.firstName} ${review.user.userInfo.lastName}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5),
          RatingBar.builder(
            initialRating: review.rate.toDouble(),
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 20,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            ignoreGestures: true,
            onRatingUpdate: (rating) {},
          ),
          SizedBox(height: 5),
          Text(
            "Cực kỳ hài lòng",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "${review.content == null ? '' : review.content}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
                review.images.length == null ? 0 : review.images.length,
                (index) {
              return SizedBox(
                height: Get.width / 3 - 32,
                width: Get.width / 3 - 16,
                child: Image.network(
                  "${review.images[index].url}",
                  fit: BoxFit.cover,
                ),
              );
            }),
          ),
          SizedBox(height: 10),
          Text(
            "Nhận xét vào ${review.createdDate != null ? DateFormat('dd-MM-yyyy').format(review.createdDate) : ''}",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingGeneral(List<Review> reviews) {
    return Obx(() => Column(
          children: [
            Container(
              width: Get.width,
              height: 150,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${controller.starAvg.value.toStringAsFixed(1)}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: controller.starAvg.value,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 16,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {},
                        ),
                        Text(
                          "${controller.totalReview.value} nhận xét",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  SizedBox(width: Get.width * 0.05),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 5,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 13,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {},
                              ),
                              new LinearPercentIndicator(
                                width: 110.0,
                                lineHeight: 5.0,
                                percent: controller.star5.value /
                                    controller.totalReview.value,
                                progressColor: Colors.black54,
                              ),
                              Text(
                                "(${controller.star5.value})",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 4,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 13,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {},
                              ),
                              new LinearPercentIndicator(
                                width: 110.0,
                                lineHeight: 5.0,
                                percent: controller.star4.value /
                                    controller.totalReview.value,
                                progressColor: Colors.black54,
                              ),
                              Text(
                                "(${controller.star4.value})",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 13,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {},
                              ),
                              new LinearPercentIndicator(
                                width: 110.0,
                                lineHeight: 5.0,
                                percent: controller.star3.value /
                                    controller.totalReview.value,
                                progressColor: Colors.black54,
                              ),
                              Text(
                                "(${controller.star3.value})",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 2,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 13,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {},
                              ),
                              new LinearPercentIndicator(
                                width: 110.0,
                                lineHeight: 5.0,
                                percent: controller.star2.value /
                                    controller.totalReview.value,
                                progressColor: Colors.black54,
                              ),
                              Text(
                                "(${controller.star2.value})",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 13,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {},
                              ),
                              new LinearPercentIndicator(
                                width: 110.0,
                                lineHeight: 5.0,
                                percent: controller.star1.value /
                                    controller.totalReview.value,
                                progressColor: Colors.black54,
                              ),
                              Text(
                                "(${controller.star1.value}) ",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: TextButton(
                onPressed: () {
                  if (authController.user.id == null ||
                      authController.user.id <= 0) {
                    Get.toNamed(Routes.USER_LOGIN);
                  } else
                    Get.toNamed(Routes.USER_RATING);
                },
                child: Text(
                  "Viết nhận xét",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: Colors.blue[900],
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
