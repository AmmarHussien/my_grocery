import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_grocery/components/main_header.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/controller/product_controller.dart';
import 'package:my_grocery/view/product/components/product_grid.dart';
import 'package:my_grocery/view/product/components/product_loading_grid.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: Obx(
              () {
                if (productController.isProductLoading.value) {
                  return const ProductLoadingGrid();
                } else {
                  if (ProductController.productList.isNotEmpty) {
                    return ProductGrid(products: ProductController.productList);
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/product_not_found.png'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Product Not Found'),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
