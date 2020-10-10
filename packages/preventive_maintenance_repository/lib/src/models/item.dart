import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Item {
  final String id;
  final String uid;
  final int index;
  final String name;

  Item({String id, String uid, int index = 0, String name = ''})
    : this.index = index ?? 0,
      this.name = name ?? '',
      this.id = id,
      this.uid = uid;

  Item copyWith({String id, String uid, int index, String name}) {
    return Item(
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
      other is Item &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        uid == other.uid &&
        index == other.index &&
        name == other.name;

  @override
  String toString() {
    return 'Item { id: $id, uid: $uid, index: $index, name: $name }';
  }

  ItemEntity toEntity() {
    return ItemEntity(id, uid, index, name);
  }

  static Item fromEntity(ItemEntity entity) {
    return Item(
      id: entity.id,
      uid: entity.uid,
      index: entity.index,
      name: entity.name
    );
  }
}