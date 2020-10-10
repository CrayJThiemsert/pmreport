import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TopicEntity extends Equatable {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String header;
  final String platform;

  const TopicEntity(this.id, this.uid, this.index, this.name, this.header, this.platform);

  @override
  List<Object> get props => [id, uid, index, name, header, platform];

  @override
  String toString() {
    return 'TopicEntity { id: $id, uid: $uid, index: $index, name: $name, header: $header, platform: $platform}';
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "uid": uid,
      "index": index,
      "name": name,
      "header": header,
      "platform": platform,
    };
  }

  static TopicEntity fromJson(Map<String, Object> json) {
    return TopicEntity(
      json["id"] as String,
      json["uid"] as String,
      json["index"] as int,
      json["name"] as String,
      json["header"] as String,
      json["platform"] as String,
    );
  }

  static TopicEntity fromSnapshot(DocumentSnapshot snap) {
    return TopicEntity(
      snap.id ?? '',
      snap.data()['uid'] ?? '',
      snap.data()['index'] ?? '',
      snap.data()['name'] ?? '',
      snap.data()['header'] ?? '',
      snap.data()['platform'] ?? '',
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "uid": uid,
      "idex": index,
      "name": name,
      "header": header,
      "platform": platform,
    };
  }
}

