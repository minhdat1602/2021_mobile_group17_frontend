import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/core/utils/utils.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_product_module/product_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCarousel extends StatelessWidget {
  final CarouselController imageCarouselController;
  final List<Product> products;
  ProductController productController = Get.put(ProductController());

  ProductCarousel({
    Key key,
    @required this.imageCarouselController,
    @required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: imageCarouselController,
      itemCount: products.length > 8 ? 8 : products.length,
      options: CarouselOptions(
        height: Get.height * .4,
        viewportFraction: .7,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeCenterPage: true,
        scrollPhysics: BouncingScrollPhysics(),
      ),
      itemBuilder: (context, index, i) {
        return Container(
          height: Get.height * .4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: _buildImageItem(products[index]),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _buildDiscountComponent(products[index]),
              ),
              _buildInfoComponent(products[index]),
            ],
          ),
        );
      },
    );
  }

  ClipRRect _buildImageItem(Product product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FadeInImage.memoryNetwork(
        height: Get.height * .3,
        placeholder: kTransparentImage,
        image: ProjectUtil.getDisplay(product),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Container _buildInfoComponent(Product product) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "${product.name}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Giá: ${PriceUtil.toCurrency(product.price)} đ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  print("CLICK PRODUCT ID: ${product.id}");
                  productController.product = product;
                  productController.addRecentlyViewed(product);
                  Get.toNamed(Routes.PRODUCT);
                },
                child: Text(
                  "Mua ngay",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountComponent(Product product) {
    return product.discount > 0
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(50, 50),
              ),
              color: Colors.redAccent,
            ),
            width: 55,
            height: 35,
            alignment: Alignment.center,
            child: Text(
              "-${(product.discount * 100 ~/ product.price)}%",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        : Text("");
  }
}
