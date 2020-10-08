import 'dart:async';

import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

abstract class PartsRepository {
  Future<void> addNewPart(Part part);
  
  Future<void> deletePart(Part part);

  Stream<List<Part>> parts(String categoryUid);

  Future<void> updatePart(Part part);
}