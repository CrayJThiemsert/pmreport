import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';
import 'entities/entities.dart';

class FirebaseCategoriesRepository implements CategoriesRepository {
  final categoriesCollection = Firestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/categories');

  @override
  Future<void> addNewCategory(Category category) {
    return categoriesCollection.add(category.toEntity().toDocument());
  }

  @override
  Stream<List<Category>> categories() {
    return categoriesCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Category.fromEntity(CategoryEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> deleteCategory(Category category) {
    return categoriesCollection.doc(category.id).delete();
  }

  @override
  Future<void> updateCategory(Category category) {
    return categoriesCollection
        .doc(category.id)
        .update(category.toEntity().toDocument());
  }




}