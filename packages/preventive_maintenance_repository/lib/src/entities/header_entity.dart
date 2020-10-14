import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HeaderEntity extends Equatable {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String inputType;

  const HeaderEntity(this.id, this.uid, this.index, this.name, this.inputType);

  @override
  List<Object> get props => [id, uid, index, name, inputType];

  @override
  String toString() {
    return 'HeaderEntity { id: $id, uid: $uid, index: $index, name: $name, inputType: $inputType}';
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "uid": uid,
      "index": index,
      "name": name,
      "inputType": inputType,
    };
  }

  static HeaderEntity fromJson(Map<String, Object> json) {
    return HeaderEntity(
      json["id"] as String,
      json["uid"] as String,
      json["index"] as int,
      json["name"] as String,
      json["inputType"] as String,
    );
  }

  static HeaderEntity fromSnapshot(DocumentSnapshot snap) {
    return HeaderEntity(
      snap.id ?? '',
      snap.data()['uid'] ?? '',
      snap.data()['index'] ?? '',
      snap.data()['name'] ?? '',
      snap.data()['inputType'] ?? '',
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "uid": uid,
      "idex": index,
      "name": name,
      "inputType": inputType,
    };
  }
}

