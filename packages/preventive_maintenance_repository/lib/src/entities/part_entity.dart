import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PartEntity extends Equatable {
  final String id;
  final String uid;
  final int index;
  final String name;

  const PartEntity(this.id, this.uid, this.index, this.name);

  @override
  List<Object> get props => [id, uid, index, name];

  @override
  String toString() {
    return 'PartEntity { id: $id, uid: $uid, index: $index, name: $name}';
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "uid": uid,
      "index": index,
      "name": name,
    };
  }

  static PartEntity fromJson(Map<String, Object> json) {
    return PartEntity(
      json["id"] as String,
      json["uid"] as String,
      json["index"] as int,
      json["name"] as String,
    );
  }

  static PartEntity fromSnapshot(DocumentSnapshot snap) {
    return PartEntity(
      snap.id ?? '',
      snap.data()['uid'] ?? '',
      snap.data()['index'] ?? '',
      snap.data()['name'] ?? '',
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "uid": uid,
      "idex": index,
      "name": name,
    };
  }
}

