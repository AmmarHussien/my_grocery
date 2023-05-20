import 'package:flutter/material.dart';
import 'package:my_grocery/model/product.dart';
import 'package:my_grocery/view/home/components/popular%20product/popular_product_card.dart';

class PopularProduct extends StatelessWidget {
  const PopularProduct({super.key, required this.products});

  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) => PopularProductCard(
          product: products[index],
        ),
      ),
    );
  }
}
