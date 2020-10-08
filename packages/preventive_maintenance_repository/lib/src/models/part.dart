import 'package:meta/meta.dart';
import '../entities/category_entity.dart';
import '../entities/entities.dart';

@immutable
class Part {
  final String id;
  final String uid;
  final int index;
  final String name;

  Part({String id, String uid, int index = 0, String name = ''})
    : this.index = index ?? 0,
      this.name = name ?? '',
      this.id = id,
      this.uid = uid;

  Part copyWith({String id, String uid, int index, String name}) {
    return Part(
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
      other is Part &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        uid == other.uid &&
        index == other.index &&
        name == other.name;

  @override
  String toString() {
    return 'Part { id: $id, uid: $uid, index: $index, name: $name }';
  }

  PartEntity toEntity() {
    return PartEntity(id, uid, index, name);
  }

  static Part fromEntity(PartEntity entity) {
    return Part(
      id: entity.id,
      uid: entity.uid,
      index: entity.index,
      name: entity.name
    );
  }
}