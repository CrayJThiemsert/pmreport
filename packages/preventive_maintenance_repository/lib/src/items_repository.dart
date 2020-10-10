import 'dart:async';

import 'package:preventive_maintenance_repository/src/models/item.dart';
import 'package:preventive_maintenance_repository/src/models/models.dart';

abstract class ItemsRepository {
  Future<void> addNewItem(Item item);
  
  Future<void> deleteItem(Item item);

  Stream<List<Item>> items(String categoryUid, String partUid, Topic topic);

  // Stream<List<Item>> templateItems(String categoryUid, String partUid, Topic topic);

  Future<void> updateItem(Item item);
}