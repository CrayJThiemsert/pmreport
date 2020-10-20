import 'package:meta/meta.dart';
import 'package:preventive_maintenance_repository/src/models/models.dart';

import '../entities/entities.dart';

@immutable
class Topic {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String header;
  final String platform;
  Part part;

  Topic(
      {String id,
      String uid,
      int index = 0,
      String name = '',
      String header = '',
      String platform = '',
      Part part})
      : this.index = index ?? 0,
        this.name = name ?? '',
        this.id = id,
        this.uid = uid,
        this.header = header,
        this.platform = platform,
        this.part = part;

  Topic copyWith(
      {String id,
      String uid,
      int index,
      String name,
      String header,
      String platform,
      Part part}) {
    return Topic(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      index: index ?? this.index,
      name: name ?? this.name,
      header: header ?? this.header,
      platform: platform ?? this.platform,
      part: part ?? this.part,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      index.hashCode ^
      name.hashCode ^
      header.hashCode ^
      platform.hashCode ^
      part.hashCode;

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
    return 'Topic { id: $id, uid: $uid, index: $index, name: $name, header: $header, platform: $platform, part: ${part} }';
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
