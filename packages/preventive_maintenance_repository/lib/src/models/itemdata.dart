import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class ItemData {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String inputType;
  String value;

  ItemData({String id, String uid, int index = 0, String name = '', String inputType = '', String value = ''})
    : this.index = index ?? 0,
      this.name = name ?? '',
      this.id = id,
      this.uid = uid,
      this.inputType = inputType,
      this.value = value;

  ItemData copyWith({String id, String uid, int index, String name, String inputType, String value}) {
    return ItemData(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      index: index ?? this.index,
      name: name ?? this.name,
      inputType: name ?? this.inputType,
      value: value ?? this.value,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ uid.hashCode ^ index.hashCode ^ name.hashCode ^ inputType.hashCode ^ value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemData &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        uid == other.uid &&
        index == other.index &&
        name == other.name &&
        inputType == other.inputType &&
        value == other.value;

  @override
  String toString() {
    return 'ItemData { id: $id, uid: $uid, index: $index, name: $name, inputType: $inputType, value: $value }';
  }

  ItemDataEntity toEntity() {
    return ItemDataEntity(
        id: id,
        uid: uid,
        index: index,
        name: name,
        inputType: inputType,
        value: value);
  }

  static ItemData fromEntity(ItemDataEntity entity) {
    return ItemData(
      id: entity.id,
      uid: entity.uid,
      index: entity.index,
      name: entity.name,
      inputType: entity.inputType,
      value: entity.value
    );
  }
}