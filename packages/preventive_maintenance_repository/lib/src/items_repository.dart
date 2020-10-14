import 'dart:async';

import 'package:preventive_maintenance_repository/src/models/item.dart';
import 'package:preventive_maintenance_repository/src/models/models.dart';

abstract class ItemsRepository {
  Future<void> addNewItem(Item item);
  
  Future<void> deleteItem(Item item);

  Stream<List<Item>> itemsStream(String categoryUid, String partUid, Topic topic);
  Future<List<Item>> itemsOnce(String categoryUid, String partUid, Topic topic);

  Future<void> updateItem(Item item);
}