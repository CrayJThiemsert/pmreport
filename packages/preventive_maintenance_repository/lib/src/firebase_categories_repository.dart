import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';
import 'entities/entities.dart';

class FirebaseCategoriesRepository implements CategoriesRepository {
  // for transaction
  final categoriesCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/categories');
  // for load list
  final categoriesLoadCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/categories').orderBy('index', descending: false);
  // final categoriesCollection = FirebaseFirestore.instance.collection('categories');

  @override
  Future<void> addNewCategory(Category category) {
    return categoriesCollection.add(category.toEntity().toDocument());
  }

  @override
  Future<List<Category>> categoriesOnce() async {
    // QuerySnapshot query = categoriesLoadCollection.get();
    // FirebaseFirestore.instance
    //     .collection('categories')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) => {
    //       querySnapshot.docs.forEach((doc) {
    //         print(doc.data()['name']);
    //       })
    //     });
    List<Category> categories;
    await categoriesLoadCollection
        .get()
        .then((QuerySnapshot querySnapshot) => {
          categories =
          querySnapshot.docs
          .map((doc) =>
              Category.fromEntity(CategoryEntity.fromSnapshot(doc))).toList()

        });
    return categories;
  }

  @override
  Stream<List<Category>> categoriesStream() {
    // FirebaseFirestore.instance
    //     .collection('categories')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) => {
    //       querySnapshot.docs.forEach((doc) {
    //         print(doc.data()['name']);
    //       })
    //     });
    // return null;
    // categoriesCollection.orderBy('index', descending: false);

    return categoriesLoadCollection.snapshots().map((snapshot) {
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