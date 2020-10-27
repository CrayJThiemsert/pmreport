part of 'itemdatas_bloc.dart';

@immutable
abstract class ItemDatasState extends Equatable {
  final String itemDataUid;
  const ItemDatasState({this.itemDataUid});

  @override
  List<Object> get props => [itemDataUid];

}

class ItemDatasLoading extends ItemDatasState {}

class ItemDatasLoaded extends ItemDatasState {
  final List<ItemData> itemDatas;
  
  const ItemDatasLoaded([this.itemDatas = const []]);

  @override
  List<Object> get props => [itemDatas];

  @override
  String toString() => 'ItemDatasLoaded { itemDatas: $itemDatas }';
}

class ItemDataLoaded extends ItemDatasState {
  final ItemData itemData;

  const ItemDataLoaded({this.itemData});

  @override
  List<Object> get props => [itemData];

  @override
  String toString() => 'ItemDataLoaded { itemData: $itemData }';
}

class ItemDatasNotLoaded extends ItemDatasState {}

