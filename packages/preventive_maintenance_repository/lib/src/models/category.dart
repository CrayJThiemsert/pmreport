import 'package:meta/meta.dart';
import '../entities/category_entity.dart';
import '../entities/entities.dart';

@immutable
class Category {
  final String id;
  final String uid;
  final int index;
  final String name;

  Category({String id, String uid, int index = 0, String name = ''})
    : this.index = index ?? 0,
      this.name = name ?? '',
      this.id = id,
      this.uid = uid;

  Category copyWith({String id, String uid, int index, String name}) {
    return Category(
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
      other is Category &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        uid == other.uid &&
        index == other.index &&
        name == other.name;

  @override
  String toString() {
    return 'Category { id: $id, uid: $uid, index: $index, name: $name }';
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id, uid, index, name);
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      id: entity.id,
      uid: entity.uid,
      index: entity.index,
      name: entity.name
    );
  }
}