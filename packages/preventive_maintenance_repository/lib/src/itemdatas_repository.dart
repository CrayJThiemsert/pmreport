import 'dart:async';

import 'package:preventive_maintenance_repository/src/models/item.dart';
import 'package:preventive_maintenance_repository/src/models/models.dart';

abstract class ItemDatasRepository {
  Future<void> addNewItemData(String categoryUid, String partUid, Topic topic, Item item, ItemData itemData);
  
  Future<void> deleteItemData(ItemData itemData);

  Stream<List<ItemData>> itemDatasStream(String categoryUid, String partUid, Topic topic, Item item);
  Future<List<ItemData>> itemDatasOnce(String categoryUid, String partUid, Topic topic, Item item);

  Future<void> updateItemData(ItemData itemData);
}