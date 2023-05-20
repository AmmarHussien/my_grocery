import 'dart:convert';

List<Product> popularProductListFromJson(String value) => List<Product>.from(
      json.decode(value)['data'].map(
            (category) => Product.popularProductListFromJson(category),
          ),
    );

class Product {
  final int id;
  final String name;
  final String description;
  final List<String> image;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
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
      );
}
