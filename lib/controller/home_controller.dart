import 'package:get/get.dart';
import 'package:my_grocery/model/ad_banner.dart';
import 'package:my_grocery/model/category.dart';
import 'package:my_grocery/service/local%20service/local_banner_service.dart';
import 'package:my_grocery/service/local%20service/local_pupular_category_service.dart';
import 'package:my_grocery/service/local%20service/local_pupular_product_service.dart';
import 'package:my_grocery/service/remote%20service/remote_banner_service.dart';
import 'package:my_grocery/service/remote%20service/remote_popular_category_service.dart';
import 'package:my_grocery/service/remote%20service/remote_popular_product_service.dart';
import '../model/product.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();

  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<Category> popularCategoryList =
      List<Category>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalPopularCategoryService _localPopularCategoryService =
      LocalPopularCategoryService();
  final LocalPopularProductService _localProductService =
      LocalPopularProductService();

  @override
  void onInit() async {
    await _localAdBannerService.init();
    await _localProductService.init();
    await _localPopularCategoryService.init();
    getAdBanners();
    getPopularCategories();
    getPopularProduct();
    super.onInit();
  }

  void getAdBanners() async {
    try {
      isBannerLoading(true);
      //assigning local ad banners befor call api
      if (_localAdBannerService.getAllAdBanners().isNotEmpty) {
        bannerList.assignAll(_localAdBannerService.getAllAdBanners());
      }
      //call api
      var result = await RemoteBannerService().get();
      if (result != null) {
        //assign api result
        bannerList.assignAll(adBannerListFromJson(result.body));
        //save api result to local bd
        _localAdBannerService.assignAllAdBanners(
          adBanners: adBannerListFromJson(result.body),
        );
      }
    } finally {
      isBannerLoading(false);
    }
  }

  void getPopularCategories() async {
    try {
      isPopularCategoryLoading(true);
      if (_localPopularCategoryService.getAllPopularCategory().isNotEmpty) {
        popularCategoryList
            .assignAll(_localPopularCategoryService.getAllPopularCategory());
      }
      var result = await RemotePopularCategoryService().get();
      if (result != null) {
        popularCategoryList.assignAll(popularCategoryListFromJson(result.body));

        _localPopularCategoryService.assignAllPopularCategory(
            popularCategories: popularCategoryListFromJson(result.body));
      }
    } finally {
      isPopularCategoryLoading(false);
    }
  }

  void getPopularProduct() async {
    try {
      isPopularProductLoading(true);
      if (_localProductService.getAllPopularProduct().isNotEmpty) {
        popularProductList
            .assignAll(_localProductService.getAllPopularProduct());
      }
      var result = await RemotePopularProductService().get();
      if (result != null) {
        popularProductList.assignAll(popularProductListFromJson(result.body));
        _localProductService.assignAllPopularProduct(
            popularProduct: popularProductListFromJson(result.body));
      }
    } finally {
      isPopularProductLoading(false);
    }
  }
}
