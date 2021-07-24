import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/admin_appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/admin_menu_drawer.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_order_module/admin_order_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_order_module/admin_status_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/order_controller.dart';
import 'package:mobile_nhom17_2021/app/data/models/status.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_order_module/status_controller.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/core/utils/utils.dart';

class AdminOrderDetailScreen extends StatefulWidget {
  @override
  _AdminOrderDetailScreenState createState() => _AdminOrderDetailScreenState();
}

class _AdminOrderDetailScreenState extends State<AdminOrderDetailScreen> {
  AdminOrderController adminOrderController = Get.put(AdminOrderController());
  AdminStatusController adminStatusController =
      Get.put(AdminStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(),
      drawer: AdminDrawer(),
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
                        "Mã đơn hàng: ${adminOrderController.order.code}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Ngày đặt hàng: ${DateFormat('kk:mm dd-MM-yyyy').format(adminOrderController.order.createdDate)}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 5),
                    Obx(() => Text(
                          "${adminOrderController.order.status.name}",
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
                            "${adminOrderController.order.user.userInfo.firstName} ${adminOrderController.order.user.userInfo.lastName}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                              "${adminOrderController.order.user.userInfo.phone}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${adminOrderController.order.user.userInfo.sonha}, ${adminOrderController.order.user.userInfo.xa}, ${adminOrderController.order.user.userInfo.huyen}, ${adminOrderController.order.user.userInfo.tinh}",
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
                      adminOrderController.order.orderDetails.length,
                      (index) => Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 80,
                                child: Image.network(
                                  "${ProjectUtil.getDisplay(adminOrderController.order.orderDetails[index].product)}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => Text(
                                        "${adminOrderController.order.orderDetails[index].product.name}",
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
                                        "${PriceUtil.toCurrency(adminOrderController.order.orderDetails[index].product.price)} đ x ${adminOrderController.order.orderDetails[index].quantity}",
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
                        "${PriceUtil.toCurrency(adminOrderController.order.totalMoney)} đ",
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
                        "${PriceUtil.toCurrency(adminOrderController.order.totalMoney - 20000)} đ",
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
                Get.dialog(
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      child: _buildConfirmChangeStatus(),
                    ),
                  ),
                );
              },
              child: Text(
                "${adminOrderController.order.status.name}",
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
    );
  }

  Widget _buildConfirmChangeStatus() {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            adminStatusController.statuses.length,
            (index) => index > 0
                ? Container(
                    width: Get.width * 3 / 5,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        Get.defaultDialog(
                          title: "NHẮC LẠI",
                          content: Text(
                              "Bạn đã chắc thay đổi trạng thái đơn hàng này"),
                          textConfirm: "Thay đổi",
                          textCancel: "Hủy",
                          cancelTextColor: Colors.red,
                          onConfirm: () {
                            // listOrderController.updateStatus(status[index]);
                            setState(() {});
                          },
                        );
                      },
                      child: Text(
                        "${adminStatusController.statuses[index].name}",
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
        ));
  }
}
