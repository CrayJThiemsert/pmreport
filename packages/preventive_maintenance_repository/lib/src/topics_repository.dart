import 'dart:async';

import 'package:preventive_maintenance_repository/src/models/topic.dart';

abstract class TopicsRepository {
  Future<void> addNewTopic(Topic topic);
  
  Future<void> deleteTopic(Topic topic);

  Stream<List<Topic>> topics(String categoryUid, String partUid);

  Future<void> updateTopic(Topic topic);
}