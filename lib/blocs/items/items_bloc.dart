import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';


part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository _itemsRepository;
  StreamSubscription _itemsSubscription;

  ItemsBloc({@required ItemsRepository itemsRepository})
      : assert(itemsRepository != null),
        _itemsRepository = itemsRepository,
        super(ItemsLoading());

  @override
  Stream<ItemsState> mapEventToState(
    ItemsEvent event,
  ) async* {
    if(event is LoadItems) {
      yield* _mapLoadItemsToState(event);
    // } if(event is LoadTemplateItems) {
    //   yield* _mapLoadTemplateItemsToState(event);
    } else if(event is AddItem) {
      yield* _mapAddItemToState(event);
    } else if(event is UpdateItem) {
      yield* _mapUpdateItemToState(event);
    } else if(event is DeleteItem) {
      yield* _mapDeleteItemToState(event);
    } else if(event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if(event is ItemsUpdated) {
      yield* _mapItemsUpdateToState(event);
    }
  }

  Stream<ItemsState> _mapLoadItemsToState(LoadItems event) async* {
    _itemsSubscription?.cancel();
    _itemsSubscription =
        _itemsRepository.items(event.categoryUid, event.partUid, event.topic)
            .listen(
                (items) => {
              // if(items.length > 0) {
                add(ItemsUpdated(items))
              // } else {
              //   _mapLoadTemplateItemsToState(event)
              // }
            },

        );
  }

  // Stream<ItemsState> _mapLoadTemplateItemsToState(LoadItems event) async* {
  //   _itemsSubscription?.cancel();
  //   _itemsSubscription =
  //       _itemsRepository.templateItems(event.categoryUid, event.partUid, event.topic)
  //           .listen(
  //             (items) => add(ItemsUpdated(items)),
  //       );
  // }

  Stream<ItemsState> _mapAddItemToState(AddItem event) async* {
    _itemsRepository.addNewItem(event.item);
  }

  Stream<ItemsState> _mapUpdateItemToState(UpdateItem event) async* {
    _itemsRepository.updateItem(event.updatedItem);
  }

  Stream<ItemsState> _mapDeleteItemToState(DeleteItem event) async* {
    _itemsRepository.deleteItem(event.item);
  }

  Stream<ItemsState> _mapClearCompletedToState() async* {
    final currentState = state;
    if(currentState is ItemsLoaded) {
      final List<Item> completedItems = currentState.items.toList();
      completedItems.forEach((completedItem) {
        _itemsRepository.deleteItem(completedItem);
      });
    }
  }

  Stream<ItemsState> _mapItemsUpdateToState(ItemsUpdated event) async* {
    yield ItemsLoaded(event.items);
  }

  @override
  Future<Function> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
