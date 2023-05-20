import 'package:hive/hive.dart';
import 'package:my_grocery/model/category.dart';

class LocalPopularCategoryService {
  late Box<Category> _popularCategoryBox;

  Future<void> init() async {
    _popularCategoryBox = await Hive.openBox<Category>('PopularCategories');
  }

  Future<void> assignAllPopularCategory({required List<Category> popularCategories}) async {
    await _popularCategoryBox.clear();
    await _popularCategoryBox.addAll(popularCategories);
  }

  List<Category> getAllPopularCategory() => _popularCategoryBox.values.toList();
}