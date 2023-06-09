import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/model/product.dart';
import 'package:my_grocery/service/remote%20service/remote_product.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  TextEditingController searchTextEditController = TextEditingController();
  RxString searchVal = ''.obs;
  static RxList<Product> productList = List<Product>.empty(growable: true).obs;
  RxBool isProductLoading = false.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().get();
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      isProductLoading(false);
    }
  }

  void getProductByName({required String keyword}) async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().getByName(
        keyword: keyword,
      );
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      isProductLoading(false);
    }
  }

  void getProductByCategory({required int categoryId}) async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().getByCategory(id: categoryId);
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      isProductLoading(false);
    }
  }
}
