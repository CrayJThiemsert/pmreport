import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';
import 'entities/entities.dart';
import 'itemdatas_repository.dart';
import 'models/topic.dart';

class FirebaseItemDatasRepository implements ItemDatasRepository {
  // for transaction
  final itemDatasCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/parts');
  // for load list

  // final itemsCollection = FirebaseFirestore.instance.collection('items');

  @override
  Future<void> addNewItemData(String categoryUid, String partUid, Topic topic, Item item, ItemData itemData) {
    String query = '/sites/nachuak_solar_power_plant/measurements/2020/categories/${categoryUid}/parts/${partUid}/topics/${topic.uid}/items_list/${item.uid}/items_data';
    final itemsDataLoadCollection = FirebaseFirestore.instance.collection(query);
    return itemsDataLoadCollection
        .doc(itemData.id)
        .set(itemData.toEntity().toDocument(), SetOptions(merge: true));
    // return itemsDataLoadCollection.add(itemData.toEntity().toDocument());
  }

  @override
  Future<List<ItemData>> itemDatasOnce(String categoryUid, String partUid, Topic topic, Item item) async {
    String query = 'templates/ui/sites/nachuak_solar_power_plant/categories/${categoryUid}/parts/${partUid}/topics/${topic.uid}/items_list';
    if(topic.platform != 'mobile') {
      query = 'templates/ui/topics/${topic.header}/items_list';
    }
    final itemsLoadCollection = FirebaseFirestore.instance.collection(query).orderBy('index', descending: false);

    List<ItemData> itemdatas;
    await itemsLoadCollection
        .get()
        .then((QuerySnapshot querySnapshot) => {
        itemdatas =
          querySnapshot.docs
              .map((doc) =>
              ItemData.fromEntity(ItemDataEntity.fromSnapshot(doc))).toList()
    }).catchError((error) => {
      print('Error - ${error.toString()}')
    });

    query = '/templates/ui/sites/nachuak_solar_power_plant/categories/${categoryUid}/parts/${partUid}/topics/${topic.uid}/headers';
    final headersLoadCollection = FirebaseFirestore.instance.collection(query).orderBy('index', descending: false);

    List<Header> headers;
    await headersLoadCollection
        .get()
        .then((QuerySnapshot querySnapshot) => {
          headers =
          querySnapshot.docs
              .map((doc) =>
              Header.fromEntity(HeaderEntity.fromSnapshot(doc))).toList()
    }).catchError((error) => {
      print('Error - ${error.toString()}')
    });

    if(headers.length == 0) {
      query = '/templates/ui/topics/${topic.header}/headers';
      final headersLoadCollection = FirebaseFirestore.instance.collection(query).orderBy('index', descending: false);

      await headersLoadCollection
          .get()
          .then((QuerySnapshot querySnapshot) => {
        headers =
            querySnapshot.docs
                .map((doc) =>
                Header.fromEntity(HeaderEntity.fromSnapshot(doc))).toList()
      }).catchError((error) => {
        print('Error - ${error.toString()}')
      });
    }

    for(var i = 0; i< itemdatas.length; i++) {
      var item = itemdatas[i];
      List<ItemData> itemDatas;
      query = '/sites/nachuak_solar_power_plant/measurements/2020/categories/${categoryUid}/parts/${partUid}/topics/${topic.uid}/items_list/${item.uid}/items_data';
      final itemsDataLoadCollection = FirebaseFirestore.instance.collection(query).orderBy('index', descending: false);
      await itemsDataLoadCollection
          .get()
          .then((QuerySnapshot querySnapshot) => {
        itemDatas =
            querySnapshot.docs
                .map((doc) =>
                ItemData.fromEntity(ItemDataEntity.fromSnapshot(doc))).toList()
      }).catchError((error) => {
        print('Error - ${error.toString()}')
      });
    };
    print('itemdatas size=$itemdatas.length');

    return itemdatas;
  }

  @override
  Stream<List<ItemData>> itemDatasStream(String categoryUid, String partUid, Topic topic, Item item) {
    String query = 'templates/ui/sites/nachuak_solar_power_plant/categories/${categoryUid}/parts/${partUid}/topics/${topic.uid}/items_list';
    if(topic.platform != 'mobile') {
      query = 'templates/ui/topics/${topic.header}/items_list';
    }
    final itemsLoadCollection = FirebaseFirestore.instance.collection(query).orderBy('index', descending: false);
    // final itemsLoadCollection = FirebaseFirestore.instance.collection('templates/ui/topics/${topic.header}/items_list').orderBy('index', descending: false);

    return itemsLoadCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ItemData.fromEntity(ItemDataEntity.fromSnapshot(doc)))
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
  Future<void> deleteItemData(ItemData itemData) {
    return itemDatasCollection.doc(itemData.id).delete();
  }

  @override
  Future<void> updateItemData(ItemData itemData) {
    return itemDatasCollection
        .doc(itemData.id)
        .update(itemData.toEntity().toDocument());
  }

}