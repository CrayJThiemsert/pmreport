import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';
import 'package:preventive_maintenance_repository/src/items_repository.dart';
import 'package:preventive_maintenance_repository/src/parts_repository.dart';
import 'package:preventive_maintenance_repository/src/topics_repository.dart';
import 'entities/entities.dart';
import 'models/topic.dart';

class FirebaseItemsRepository implements ItemsRepository {
  // for transaction
  final itemsCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/parts');
  // for load list

  // final itemsCollection = FirebaseFirestore.instance.collection('items');

  @override
  Future<void> addNewItem(Item item) {
    return itemsCollection.add(item.toEntity().toDocument());
  }

  @override
  Stream<List<Item>> items(String categoryUid, String partUid, Topic topic) {
    String query = 'templates/ui/sites/nachuak_solar_power_plant/categories/${categoryUid}/parts/${partUid}/topics/${topic.uid}/items_list';
    if(topic.platform != 'mobile') {
      query = 'templates/ui/topics/${topic.header}/items_list';
    }
    final itemsLoadCollection = FirebaseFirestore.instance.collection(query).orderBy('index', descending: false);
    // final itemsLoadCollection = FirebaseFirestore.instance.collection('templates/ui/topics/${topic.header}/items_list').orderBy('index', descending: false);
    return itemsLoadCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Item.fromEntity(ItemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  // @override
  // Stream<List<Item>> templateItems(String categoryUid, String partUid, Topic topic) {
  //   final uiTopicsItemsLoadCollection = FirebaseFirestore.instance.collection('templates/ui/topics/${topic.header}/items_list').orderBy('index', descending: false);
  //   return uiTopicsItemsLoadCollection.snapshots().map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => Item.fromEntity(ItemEntity.fromSnapshot(doc)))
  //         .toList();
  //   });
  // }

  @override
  Future<void> deleteItem(Item item) {
    return itemsCollection.doc(item.id).delete();
  }

  @override
  Future<void> updateItem(Item item) {
    return itemsCollection
        .doc(item.id)
        .update(item.toEntity().toDocument());
  }

}