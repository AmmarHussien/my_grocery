import 'package:hive/hive.dart';
import 'package:my_grocery/model/product.dart';

class LocalPopularProductService {
  late Box<Product> _popularProductBox;

  Future<void> init() async {
    _popularProductBox = await Hive.openBox<Product>('PopularProduct');
  }

  Future<void> assignAllPopularProduct(
      {required List<Product> popularProduct}) async {
    await _popularProductBox.clear();
    await _popularProductBox.addAll(popularProduct);
  }

  List<Product> getAllPopularProduct() =>
      _popularProductBox.values.toList();
}
