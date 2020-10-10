import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Topic {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String header;
  final String platform;

  Topic({String id, String uid, int index = 0, String name = '', String header = '', String platform = '', })
    : this.index = index ?? 0,
      this.name = name ?? '',
      this.id = id,
      this.uid = uid,
      this.header = header,
      this.platform = platform;

  Topic copyWith({String id, String uid, int index, String name, String header, String platform}) {
    return Topic(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      index: index ?? this.index,
      name: name ?? this.name,
      header: header ?? this.header,
      platform: platform ?? this.platform,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ uid.hashCode ^ index.hashCode ^ name.hashCode ^ header.hashCode ^ platform.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Topic &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        uid == other.uid &&
        index == other.index &&
        name == other.name &&
        header == other.header &&
        platform == other.platform;

  @override
  String toString() {
    return 'Topic { id: $id, uid: $uid, index: $index, name: $name, header: $header, platform: $platform }';
  }

  TopicEntity toEntity() {
    return TopicEntity(id, uid, index, name, header, platform);
  }

  static Topic fromEntity(TopicEntity entity) {
    return Topic(
      id: entity.id,
      uid: entity.uid,
      index: entity.index,
      name: entity.name,
      header: entity.header,
      platform: entity.platform,
    );
  }
}