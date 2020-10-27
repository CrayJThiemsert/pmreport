part of 'itemdatas_bloc.dart';

@immutable
abstract class ItemDatasEvent extends Equatable {
  const ItemDatasEvent();

  @override
  List<Object> get props => [];
}

class LoadItemDatas extends ItemDatasEvent {
  final String categoryUid;
  final String partUid;
  final String topicUid;
  final Topic topic;
  final Item item;

  const LoadItemDatas(this.categoryUid, this.partUid, this.topicUid, this.topic, this.item);

  @override
  List<Object> get props => [categoryUid, partUid, topicUid, topic, item];

  @override
  String toString() => 'LoadItemDatas { categoryUid: $categoryUid, partUid: $partUid, topicUid: $topicUid, topic: $topic, item: ${item} }';
}

class LoadItemData extends ItemDatasEvent {
  final String categoryUid;
  final String partUid;
  final String topicUid;
  final Topic topic;
  final Item item;
  final String itemDataUid;

  const LoadItemData(this.categoryUid, this.partUid, this.topicUid, this.topic, this.item, this.itemDataUid);

  @override
  List<Object> get props => [categoryUid, partUid, topicUid, topic, item, itemDataUid];

  @override
  String toString() => 'LoadItemData { itemDataUid: $itemDataUid, categoryUid: $categoryUid, partUid: $partUid, topicUid: $topicUid, topic: $topic, item: ${item} }';
}

class AddItemData extends ItemDatasEvent {
  final String categoryUid;
  final String partUid;
  final String topicUid;
  final Topic topic;
  final Item item;
  final ItemData itemData;
  
  const AddItemData(this.categoryUid, this.partUid, this.topicUid, this.topic, this.item, this.itemData);

  @override
  List<Object> get props => [itemData];

  @override
  String toString() => 'AddItemData { item: $itemData }';
}

class UpdateItemData extends ItemDatasEvent {
  final String categoryUid;
  final String partUid;
  final String topicUid;
  final Topic topic;
  final Item item;
  final ItemData updatedItemData;

  const UpdateItemData(this.categoryUid, this.partUid, this.topicUid, this.topic, this.item, this.updatedItemData);

  @override
  List<Object> get props => [updatedItemData];

  @override
  String toString() => 'UpdateItemData { updatedItemData: $updatedItemData }';
}

class DeleteItemData extends ItemDatasEvent {
  final String categoryUid;
  final String partUid;
  final String topicUid;
  final Topic topic;
  final Item item;
  final ItemData itemData;

  const DeleteItemData(this.categoryUid, this.partUid, this.topicUid, this.topic, this.item, this.itemData);

  @override
  List<Object> get props => [itemData];

  @override
  String toString() => 'DeleteItemData { item: $itemData }';
}

class ClearCompleted extends ItemDatasEvent {}

class ItemDatasUpdated extends ItemDatasEvent {
  final List<ItemData> itemDatas;

  const ItemDatasUpdated(this.itemDatas);

  @override
  List<Object> get props => [itemDatas];
}

class ItemDataUpdated extends ItemDatasEvent {
  final ItemData itemData;

  const ItemDataUpdated(this.itemData);

  @override
  List<Object> get props => [itemData];
}
