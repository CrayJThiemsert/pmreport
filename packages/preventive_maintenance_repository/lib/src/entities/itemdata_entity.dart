import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ItemDataEntity extends Equatable {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String inputType;
  final String value;

  const ItemDataEntity({this.id, this.uid, this.index, this.name, this.inputType, this.value});

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
      id: json["id"] as String,
      uid: json["uid"] as String,
      index: json["index"] as int,
      name: json["name"] as String,
      inputType: json["inputType"] as String,
      value: json["value"] as String,
    );
  }

  static ItemDataEntity fromSnapshot(DocumentSnapshot snap) {
    if(snap.exists) {
      print('snap.data().isEmpty=${snap.data().isEmpty}');
      print('snap.data().length=${snap.data().length}');
      return ItemDataEntity(
        id: snap.id ?? '',
        uid: snap.data()['uid'] ?? '',
        index: snap.data()['index'] ?? '',
        name: snap.data()['name'] ?? '',
        inputType: snap.data()['inputType'] ?? '',
        value: snap.data()['value'] ?? '',
      );
    } else {
      return ItemDataEntity();
    }
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

