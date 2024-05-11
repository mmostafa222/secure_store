import 'package:flutter/foundation.dart';
import 'package:secure_store/feature/presentation/model/view/view_model/categoryList.dart';

class CategoryModel {
  final String products;

  CategoryModel({required this.products});
}

List<CategoryModel> Cate = [
  CategoryModel(products: category[0]),
  CategoryModel(products: category[1]),
  CategoryModel(products: category[2]),
  CategoryModel(products: category[3]),
];
