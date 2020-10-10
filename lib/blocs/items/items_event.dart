part of 'items_bloc.dart';

@immutable
abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends ItemsEvent {
  final String categoryUid;
  final String partUid;
  final String topicUid;
  final Topic topic;

  const LoadItems(this.categoryUid, this.partUid, this.topicUid, this.topic);

  @override
  List<Object> get props => [categoryUid, partUid, topicUid, topic];

  @override
  String toString() => 'LoadItems { categoryUid: $categoryUid, partUid: $partUid, topicUid: $topicUid, topic: $topic }';
}

class LoadTemplateItems extends ItemsEvent {
  final String categoryUid;
  final String partUid;
  final String topicUid;
  final Topic topic;

  const LoadTemplateItems(this.categoryUid, this.partUid, this.topicUid, this.topic);

  @override
  List<Object> get props => [categoryUid, partUid, topicUid, topic];

  @override
  String toString() => 'LoadTemplateItems { categoryUid: $categoryUid, partUid: $partUid, topicUid: $topicUid, topic: $topic }';
}

class AddItem extends ItemsEvent {
  final Item item;
  
  const AddItem(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'AddItem { item: $item }';
}

class UpdateItem extends ItemsEvent {
  final Item updatedItem;

  const UpdateItem(this.updatedItem);

  @override
  List<Object> get props => [updatedItem];

  @override
  String toString() => 'UpdateItem { updatedItem: $updatedItem }';
}

class DeleteItem extends ItemsEvent {
  final Item item;

  const DeleteItem(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'DeleteItem { item: $item }';
}

class ClearCompleted extends ItemsEvent {}

class ItemsUpdated extends ItemsEvent {
  final List<Item> items;

  const ItemsUpdated(this.items);

  @override
  List<Object> get props => [items];
}
