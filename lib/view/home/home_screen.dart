import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/view/home/components/carousel%20slider/carousel_slider_view.dart';
import 'package:my_grocery/view/home/components/popular%20category/popular_category.dart';
import 'package:my_grocery/view/home/components/popular%20category/popular_category_loading.dart';

import '../../components/main_header.dart';
import 'components/carousel slider/carousel_loading.dart';
import 'components/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainHeader(),
          Obx(() {
            if (homeController.bannerList.isNotEmpty) {
              return CarouselSliderView(
                bannerList: homeController.bannerList,
              );
            } else {
              return const CarouselLoading();
            }
          }),
          const SectionTitle(
            title: 'Popular Catogory',
          ),
          Obx(() {
            if (homeController.popularCategoryList.isNotEmpty) {
              return PopularCategory(
                categories: homeController.popularCategoryList,
              );
            } else {
              return const PopularCategoryLoading();
            }
          })
        ],
      ),
    );
  }
}
