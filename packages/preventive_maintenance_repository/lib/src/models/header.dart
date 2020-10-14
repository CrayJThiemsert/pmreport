import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Header {
  final String id;
  final String uid;
  final int index;
  final String name;
  final String inputType;

  Header({String id, String uid, int index = 0, String name = '', String inputType = ''})
    : this.index = index ?? 0,
      this.name = name ?? '',
      this.id = id,
      this.uid = uid,
      this.inputType = inputType;

  Header copyWith({String id, String uid, int index, String name, String inputType}) {
    return Header(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      index: index ?? this.index,
      name: name ?? this.name,
      inputType: name ?? this.inputType,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ uid.hashCode ^ index.hashCode ^ name.hashCode ^ inputType.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Header &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        uid == other.uid &&
        index == other.index &&
        name == other.name &&
        inputType == other.inputType;

  @override
  String toString() {
    return 'Header { id: $id, uid: $uid, index: $index, name: $name, inputType: $inputType }';
  }

  HeaderEntity toEntity() {
    return HeaderEntity(id, uid, index, name, inputType);
  }

  static Header fromEntity(HeaderEntity entity) {
    return Header(
      id: entity.id,
      uid: entity.uid,
      index: entity.index,
      name: entity.name,
      inputType: entity.inputType,
    );
  }
}