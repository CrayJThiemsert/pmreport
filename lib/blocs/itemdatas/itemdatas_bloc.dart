import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';


part 'itemdatas_event.dart';
part 'itemdatas_state.dart';

class ItemDatasBloc extends Bloc<ItemDatasEvent, ItemDatasState> {
  final ItemDatasRepository _itemDatasRepository;
  StreamSubscription _itemDatasSubscription;

  ItemDatasBloc({@required ItemDatasRepository itemDatasRepository})
      : assert(itemDatasRepository != null),
        _itemDatasRepository = itemDatasRepository,
        super(ItemDatasLoading());
    //     super(const ItemDatasState.unknown()) {
    // _itemDatasSubscription = _itemDatasRepository.listen(
    //       (itemData) => add(AddItemData(itemData)),
    // );

  @override
  Stream<ItemDatasState> mapEventToState(
    ItemDatasEvent event,
  ) async* {
    if(event is LoadItemDatas) {
      // yield* _mapLoadItemDatasStreamToState(event);
      yield* _mapLoadItemDatasOnceToState(event);
    } else if(event is AddItemData) {
      yield* _mapAddItemDataToState(event);
    } else if(event is UpdateItemData) {
      yield* _mapUpdateItemDataToState(event);
    } else if(event is DeleteItemData) {
      yield* _mapDeleteItemDataToState(event);
    } else if(event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if(event is ItemDatasUpdated) {
      yield* _mapItemDatasUpdateToState(event);
    }
  }

  Stream<ItemDatasState> _mapLoadItemDatasOnceToState(LoadItemDatas event) async* {
    var itemDatas = await _itemDatasRepository.itemDatasOnce(event.categoryUid, event.partUid, event.topic, event.item);
    add(ItemDatasUpdated(itemDatas));
  }

  Stream<ItemDatasState> _mapLoadItemDatasStreamToState(LoadItemDatas event) async* {
    _itemDatasSubscription?.cancel();

    _itemDatasSubscription =
        _itemDatasRepository.itemDatasStream(event.categoryUid, event.partUid, event.topic, event.item)
            .listen(
                (items) => {
                add(ItemDatasUpdated(items))
            },
        );
  }

  // Stream<ItemDatasState> _mapLoadTemplateItemDatasToState(LoadItemDatas event) async* {
  //   _itemsSubscription?.cancel();
  //   _itemsSubscription =
  //       _itemsRepository.templateItemDatas(event.categoryUid, event.partUid, event.topic)
  //           .listen(
  //             (items) => add(ItemDatasUpdated(items)),
  //       );
  // }

  Stream<ItemDatasState> _mapAddItemDataToState(AddItemData event) async* {
    _itemDatasRepository.addNewItemData(event.categoryUid, event.partUid, event.topic, event.item, event.itemData);
  }

  Stream<ItemDatasState> _mapUpdateItemDataToState(UpdateItemData event) async* {
    _itemDatasRepository.updateItemData(event.updatedItemData);
  }

  Stream<ItemDatasState> _mapDeleteItemDataToState(DeleteItemData event) async* {
    _itemDatasRepository.deleteItemData(event.itemData);
  }

  Stream<ItemDatasState> _mapClearCompletedToState() async* {
    final currentState = state;
    if(currentState is ItemDatasLoaded) {
      final List<ItemData> completedItemDatas = currentState.itemDatas.toList();
      completedItemDatas.forEach((completedItemData) {
        _itemDatasRepository.deleteItemData(completedItemData);
      });
    }
  }

  Stream<ItemDatasState> _mapItemDatasUpdateToState(ItemDatasUpdated event) async* {
    yield ItemDatasLoaded(event.itemDatas);
  }

  @override
  Future<Function> close() {
    _itemDatasSubscription?.cancel();
    return super.close();
  }
}
