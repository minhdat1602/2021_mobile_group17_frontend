import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/services/product_api.dart';
import 'package:mobile_nhom17_2021/app/data/services/shop_api.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeController extends GetxController {
  ShopAPI shopAPI = Get.put(ShopAPI());

  YoutubePlayerController youtubePlayerController;
  CarouselController imageCarouselController;
  VideoPlayerController videoPlayerController;

  final asset = "assets/videos/banner.mp4";
  String _videoId = "pzVG8RTYDHg";

  var bestseller = [];
  var discount = [];

  Rx<bool> _loaded = false.obs;
  get loaded => this._loaded.value;
  set loaded(value) => this._loaded.value = value;

  @override
  void onInit() {
    super.onInit();
    imageCarouselController = CarouselController();
    videoPlayerController = VideoPlayerController.asset(asset)
      ..addListener(() {})
      ..setLooping(true)
      // ..initialize().then((_) => videoPlayerController.play());
      ..initialize();
  
    initData();
  }

  initData() async {
    try {
      bestseller = await shopAPI.fetchProductNew();
      discount = await shopAPI.fetchProductDiscount();
      _loaded.value = true;
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
}
