import 'dart:convert';
import 'package:hive/hive.dart';

import 'tag.dart';
part 'product.g.dart';

List<Product> popularProductListFromJson(String value) => List<Product>.from(
      json.decode(value)['data'].map(
            (value) => Product.popularProductListFromJson(value),
          ),
    );
List<Product> productListFromJson(String value) => List<Product>.from(
      json.decode(value)['data'].map(
            (value) => Product.productFromJson(value),
          ),
    );

@HiveType(typeId: 3)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<String> image;
  @HiveField(4)
  final List<Tag> tags;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.tags,
  });

  factory Product.popularProductListFromJson(Map<String, dynamic> data) =>
      Product(
        id: data['id'],
        name: data['attributes']['product']['data']['attributes']['name'],
        description: data['attributes']['product']['data']['attributes']
            ['description'],
        image: List<String>.from(
          data['attributes']['product']['data']['attributes']['images']['data']
              .map(
            (value) => value['attributes']['url'],
          ),
        ),
        tags: [],
      );

  factory Product.productFromJson(Map<String, dynamic> data) => Product(
        id: data['id'],
        name: data['attributes']['name'],
        description: data['attributes']['description'],
        image: List<String>.from(
          data['attributes']['images']['data'].map(
            (value) => value['attributes']['url'],
          ),
        ),
        tags: List<Tag>.from(
          data['attributes']['tags']['data']
              .map((value) => Tag.fromJson(value)),
        ),
      );
}
