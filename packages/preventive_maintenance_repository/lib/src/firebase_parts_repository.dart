import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';
import 'package:preventive_maintenance_repository/src/parts_repository.dart';
import 'entities/entities.dart';

class FirebasePartsRepository implements PartsRepository {
  // for transaction
  final partsCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/parts');
  // for load list

  // final partsCollection = FirebaseFirestore.instance.collection('parts');

  @override
  Future<void> addNewPart(Part part) {
    return partsCollection.add(part.toEntity().toDocument());
  }

  @override
  Stream<List<Part>> parts(String categoryUid) {
    final partsLoadCollection = FirebaseFirestore.instance.collection('templates/ui/sites/nachuak_solar_power_plant/categories/${categoryUid}/parts').orderBy('index', descending: false);
    return partsLoadCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Part.fromEntity(PartEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> deletePart(Part part) {
    return partsCollection.doc(part.id).delete();
  }

  @override
  Future<void> updatePart(Part part) {
    return partsCollection
        .doc(part.id)
        .update(part.toEntity().toDocument());
  }




}