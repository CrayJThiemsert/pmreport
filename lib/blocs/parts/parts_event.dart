part of 'parts_bloc.dart';

@immutable
abstract class PartsEvent extends Equatable {
  const PartsEvent();

  @override
  List<Object> get props => [];
}

class LoadParts extends PartsEvent {
  final String categoryUid;

  const LoadParts(this.categoryUid);

  @override
  List<Object> get props => [categoryUid];

  @override
  String toString() => 'LoadParts { categoryUid: $categoryUid }';
}

class AddPart extends PartsEvent {
  final Part part;
  
  const AddPart(this.part);

  @override
  List<Object> get props => [part];

  @override
  String toString() => 'AddPart { part: $part }';
}

class UpdatePart extends PartsEvent {
  final Part updatedPart;

  const UpdatePart(this.updatedPart);

  @override
  List<Object> get props => [updatedPart];

  @override
  String toString() => 'UpdatePart { updatedPart: $updatedPart }';
}

class DeletePart extends PartsEvent {
  final Part part;

  const DeletePart(this.part);

  @override
  List<Object> get props => [part];

  @override
  String toString() => 'DeletePart { part: $part }';
}

class ClearCompleted extends PartsEvent {}

class PartsUpdated extends PartsEvent {
  final List<Part> parts;

  const PartsUpdated(this.parts);

  @override
  List<Object> get props => [parts];
}
