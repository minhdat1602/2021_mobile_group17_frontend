import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/controllers/order_controller.dart';
import 'package:mobile_nhom17_2021/app/controllers/status_controller.dart';
import 'package:mobile_nhom17_2021/app/models/order.dart';
import 'package:mobile_nhom17_2021/app/controllers/checkout_controller.dart';
import 'package:mobile_nhom17_2021/app/models/product.dart';
import 'package:mobile_nhom17_2021/app/models/status.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:mobile_nhom17_2021/app/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/utils/utils.dart';

class MyOrderDetailScreen extends StatefulWidget {
  static String routeName = "/my-order-detail";

  @override
  _MyOrderDetailScreenState createState() => _MyOrderDetailScreenState();
}

class _MyOrderDetailScreenState extends State<MyOrderDetailScreen> {
  // Order order;
  CheckoutController checkoutController =
      Get.put<CheckoutController>(CheckoutController());
  ListOrderController listOrderController = Get.put(ListOrderController());
  StatusController statusController = Get.put(StatusController());
  @override
  void initState() {
    // order = checkoutController.order.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark, // Màu icon giờ pin trên status bar
          title: Text(
            "Thông tin đơn hàng",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          // leading: IconButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          // ),
          foregroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Get.offNamed(Routes.INITIAL);
              },
              child: Text(
                "Trang chủ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300],
                  )
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: Colors.blue[300],
                    size: 35,
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          "Mã đơn hàng: ${listOrderController.order.value.code}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Ngày đặt hàng: ${DateFormat('kk:mm dd-MM-yyyy').format(listOrderController.order.value.createdDate)}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(() => Text(
                            "${listOrderController.order.value.status.name}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300],
                  )
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue[300],
                    size: 35,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Địa chỉ nhận hàng",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${listOrderController.order.value.user.userInfo.firstName} ${listOrderController.order.value.user.userInfo.lastName}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                "${listOrderController.order.value.user.userInfo.phone}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${listOrderController.order.value.user.userInfo.sonha}, ${listOrderController.order.value.user.userInfo.xa}, ${listOrderController.order.value.user.userInfo.huyen}, ${listOrderController.order.value.user.userInfo.tinh}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300],
                  )
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business_center_outlined,
                        color: Colors.blue[300],
                        size: 35,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Thông tin kiện hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 5),
                  Obx(
                    () => Column(
                      children: List.generate(
                        listOrderController.order.value.orderDetails.length,
                        (index) => Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 80,
                                  child: Image.network(
                                    "${ProjectUtil.getDisplay(listOrderController.order.value.orderDetails[index].product)}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                          "${listOrderController.order.value.orderDetails[index].product.name}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Cung cấp bởi",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Obx(
                                        () => Text(
                                          "${PriceUtil.toCurrency(listOrderController.order.value.orderDetails[index].product.price)} đ x ${listOrderController.order.value.orderDetails[index].quantity}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300],
                  )
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.airport_shuttle_outlined,
                    color: Colors.blue[300],
                    size: 35,
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hình thức giao hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Giao hàng tiết kiệm",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300],
                  )
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.blue[300],
                    size: 35,
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hình thức thanh toán",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Thanh toán tiền mặt",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300],
                  )
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tạm tính",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Obx(
                        () => Text(
                          "${PriceUtil.toCurrency(listOrderController.order.value.totalMoney)} đ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phí vận chuyển",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "20,000 đ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Thành tiền",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Obx(
                        () => Text(
                          "${PriceUtil.toCurrency(listOrderController.order.value.totalMoney - 20000)} đ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300],
                  )
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  // Get.dialog(
                  //   Center(
                  //     child: Container(
                  //       color: Colors.transparent,
                  //       child: FutureBuilder(
                  //         future: statusController.status.value,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.hasData) {
                  //             return _buildConfirmChangeStatus(snapshot.data);
                  //           } else if (snapshot.hasError) {
                  //             return Center(child: Text("ERROR"));
                  //           } else {
                  //             return Center(
                  //                 child: CircularProgressIndicator(
                  //                     color: Colors.red));
                  //           }
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
                child: Text(
                  "${listOrderController.order.value.status.name == 'Đã giao' || listOrderController.order.value.status.name == 'Đã hủy' ? 'Mua lại' : 'Hủy đơn hàng'}",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildConfirmChangeStatus(List<Status> status) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        status.length,
        (index) => index > 0
            ? Container(
                width: Get.width * 3 / 5,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                    Get.defaultDialog(
                      title: "NHẮC LẠI",
                      content:
                          Text("Bạn đã chắc thay đổi trạng thái đơn hàng này"),
                      textConfirm: "Thay đổi",
                      textCancel: "Hủy",
                      cancelTextColor: Colors.red,
                      onConfirm: () {
                        listOrderController.updateStatus(status[index]);
                        setState(() {});
                      },
                    );
                  },
                  child: Text(
                    "${status[index].name}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(16),
                  ),
                ),
              )
            : Text(""),
      ),
    );
  }
}
