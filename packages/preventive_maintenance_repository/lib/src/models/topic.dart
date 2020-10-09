import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Topic {
  final String id;
  final String uid;
  final int index;
  final String name;

  Topic({String id, String uid, int index = 0, String name = ''})
    : this.index = index ?? 0,
      this.name = name ?? '',
      this.id = id,
      this.uid = uid;

  Topic copyWith({String id, String uid, int index, String name}) {
    return Topic(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      index: index ?? this.index,
      name: name ?? this.name,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ uid.hashCode ^ index.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Topic &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        uid == other.uid &&
        index == other.index &&
        name == other.name;

  @override
  String toString() {
    return 'Topic { id: $id, uid: $uid, index: $index, name: $name }';
  }

  TopicEntity toEntity() {
    return TopicEntity(id, uid, index, name);
  }

  static Topic fromEntity(TopicEntity entity) {
    return Topic(
      id: entity.id,
      uid: entity.uid,
      index: entity.index,
      name: entity.name
    );
  }
}