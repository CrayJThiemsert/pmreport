import 'dart:async';

import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

abstract class CategoriesRepository {
  Future<void> addNewCategory(Category category);
  
  Future<void> deleteCategory(Category category);

  Stream<List<Category>> categoriesStream();

  Future<List<Category>> categoriesOnce();

  Future<void> updateCategory(Category category);
}