import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_rating_module/rating_controller.dart';
import 'package:mobile_nhom17_2021/app/core/utils/utils.dart';

class RatingScreen extends GetWidget<RatingController> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      child: Obx(() => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              brightness: Brightness.dark,
              centerTitle: false,
              title: Text(
                "Viết đánh giá",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              width: Get.width,
              height: Get.height,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${ProjectUtil.getRatingStr(controller.rate.value)}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        RatingBar.builder(
                          initialRating: controller.rate.value.toDouble(),
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 40,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            controller.rate.value = rating.toInt();
                            print("rating: $controller.rate.value");
                          },
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: Get.width,
                          child: TextButton.icon(
                            onPressed: () async {
                              controller.getImage();
                            },
                            icon: Icon(Icons.add_a_photo,
                                color: Colors.blue[900]),
                            label: Text(
                              "Thêm hình ảnh",
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 18),
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
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            direction: Axis.horizontal,
                            children: controller.pickedImages != null
                                ? List.generate(
                                    controller.pickedImages.length,
                                    (index) => Container(
                                      width: Get.width / 5,
                                      height: Get.width / 5,
                                      child: IconButton(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.highlight_remove,
                                          color: Colors.brown[600],
                                        ),
                                        onPressed: () {
                                          controller.pickedImages
                                              .removeAt(index);
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(controller
                                              .pickedImages[index].path)),
                                        ),
                                      ),
                                    ),
                                  )
                                : [],
                          ),
                        ),
                        SizedBox(height: 15),
                        TextField(
                          maxLines: null,
                          minLines: 3,
                          onChanged: (value) =>
                              controller.content.value = value,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Đánh của giá bạn về sản phẩm",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (controller.rate.value > 0) {
                              // Bật loading icon
                              Get.dialog(
                                Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white)),
                                barrierDismissible: false,
                              );
                              await controller.rating(); // Thực hiện đánh giá
                              if (Get.isDialogOpen)
                                Get.back(); // Tắt Loading icon
                              Get.dialog(AlertDialog(
                                title: Text("Gửi đánh giá"),
                                content: Text("Đánh giá của bạn đá được gửi"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        if (Get.isDialogOpen) Get.back();
                                        Get.back();
                                      },
                                      child: Text("OK")),
                                ],
                              ));
                            } else if (controller.rate.value <= 0) {
                              Get.rawSnackbar(
                                messageText: Text(
                                  "Chọn số sao mà bạn muốn đánh giá",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.grey[200],
                              );
                            }
                          },
                          child: Text("Gửi"),
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.bottomCenter,
                            primary: Colors.blue[900],
                            fixedSize: Size.fromWidth(Get.width),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
