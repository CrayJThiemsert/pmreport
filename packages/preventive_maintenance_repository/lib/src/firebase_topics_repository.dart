import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';
import 'package:preventive_maintenance_repository/src/parts_repository.dart';
import 'package:preventive_maintenance_repository/src/topics_repository.dart';
import 'entities/entities.dart';
import 'models/topic.dart';

class FirebaseTopicsRepository implements TopicsRepository {
  // for transaction
  final topicsCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/parts');
  // for load list

  // final topicsCollection = FirebaseFirestore.instance.collection('topics');

  @override
  Future<void> addNewTopic(Topic topic) {
    return topicsCollection.add(topic.toEntity().toDocument());
  }

  @override
  Stream<List<Topic>> topics(String categoryUid, String partUid) {
    final topicsLoadCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/categories/${categoryUid}/parts/${partUid}/topics').orderBy('index', descending: false);
    return topicsLoadCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Topic.fromEntity(TopicEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> deleteTopic(Topic topic) {
    return topicsCollection.doc(topic.id).delete();
  }

  @override
  Future<void> updateTopic(Topic topic) {
    return topicsCollection
        .doc(topic.id)
        .update(topic.toEntity().toDocument());
  }




}