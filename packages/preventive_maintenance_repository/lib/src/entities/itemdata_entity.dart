import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ItemDataEntity extends Equatable {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String inputType;
  final String value;

  const ItemDataEntity(this.id, this.uid, this.index, this.name, this.inputType, this.value);

  @override
  List<Object> get props => [id, uid, index, name, inputType, value];

  @override
  String toString() {
    return 'ItemDataEntity { id: $id, uid: $uid, index: $index, name: $name, inputType: $inputType, value: $value }';
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "uid": uid,
      "index": index,
      "name": name,
      "inputType": inputType,
      "value": value,
    };
  }

  static ItemDataEntity fromJson(Map<String, Object> json) {
    return ItemDataEntity(
      json["id"] as String,
      json["uid"] as String,
      json["index"] as int,
      json["name"] as String,
      json["inputType"] as String,
      json["value"] as String,
    );
  }

  static ItemDataEntity fromSnapshot(DocumentSnapshot snap) {
    return ItemDataEntity(
      snap.id ?? '',
      snap.data()['uid'] ?? '',
      snap.data()['index'] ?? '',
      snap.data()['name'] ?? '',
      snap.data()['inputType'] ?? '',
      snap.data()['value'] ?? '',
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "uid": uid,
      "index": index,
      "name": name,
      "inputType": inputType,
      "value": value,
    };
  }
}

