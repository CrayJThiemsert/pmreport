import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';


part 'parts_event.dart';
part 'parts_state.dart';

class PartsBloc extends Bloc<PartsEvent, PartsState> {
  final PartsRepository _partsRepository;
  StreamSubscription _partsSubscription;

  PartsBloc({@required PartsRepository partsRepository})
      : assert(partsRepository != null),
        _partsRepository = partsRepository,
        super(PartsLoading());

  @override
  Stream<PartsState> mapEventToState(
    PartsEvent event,
  ) async* {
    if(event is LoadParts) {
      yield* _mapLoadPartsToState(event);
    } else if(event is AddPart) {
      yield* _mapAddPartToState(event);
    } else if(event is UpdatePart) {
      yield* _mapUpdatePartToState(event);
    } else if(event is DeletePart) {
      yield* _mapDeletePartToState(event);
    } else if(event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if(event is PartsUpdated) {
      yield* _mapPartsUpdateToState(event);
    }
  }

  Stream<PartsState> _mapLoadPartsToState(LoadParts event) async* {
    _partsSubscription?.cancel();
    _partsSubscription = _partsRepository.parts(event.categoryUid).listen(
          (parts) => add(PartsUpdated(parts)),
    );
  }

  Stream<PartsState> _mapAddPartToState(AddPart event) async* {
    _partsRepository.addNewPart(event.part);
  }

  Stream<PartsState> _mapUpdatePartToState(UpdatePart event) async* {
    _partsRepository.updatePart(event.updatedPart);
  }

  Stream<PartsState> _mapDeletePartToState(DeletePart event) async* {
    _partsRepository.deletePart(event.part);
  }

  Stream<PartsState> _mapClearCompletedToState() async* {
    final currentState = state;
    if(currentState is PartsLoaded) {
      final List<Part> completedParts =
          currentState.parts.toList();
      completedParts.forEach((completedPart) {
        _partsRepository.deletePart(completedPart);
      });
    }
  }

  Stream<PartsState> _mapPartsUpdateToState(PartsUpdated event) async* {
    yield PartsLoaded(event.parts);
  }

  @override
  Future<Function> close() {
    _partsSubscription?.cancel();
    return super.close();
  }
}
