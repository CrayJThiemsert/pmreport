part of 'itemdatas_bloc.dart';

@immutable
abstract class ItemDatasState extends Equatable {
  const ItemDatasState();

  @override
  List<Object> get props => [];
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

class ItemDatasNotLoaded extends ItemDatasState {}

