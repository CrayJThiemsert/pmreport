import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';


part 'topics_event.dart';
part 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final TopicsRepository _topicsRepository;
  StreamSubscription _topicsSubscription;

  TopicsBloc({@required TopicsRepository topicsRepository})
      : assert(topicsRepository != null),
        _topicsRepository = topicsRepository,
        super(TopicsLoading());

  @override
  Stream<TopicsState> mapEventToState(
    TopicsEvent event,
  ) async* {
    if(event is LoadTopics) {
      yield* _mapLoadTopicsToState(event);
    } else if(event is AddTopic) {
      yield* _mapAddTopicToState(event);
    } else if(event is UpdateTopic) {
      yield* _mapUpdateTopicToState(event);
    } else if(event is DeleteTopic) {
      yield* _mapDeleteTopicToState(event);
    } else if(event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if(event is TopicsUpdated) {
      yield* _mapTopicsUpdateToState(event);
    }
  }

  Stream<TopicsState> _mapLoadTopicsToState(LoadTopics event) async* {
    _topicsSubscription?.cancel();
    _topicsSubscription = _topicsRepository.topics(event.categoryUid, event.partUid).listen(
          (topics) => add(TopicsUpdated(topics)),
    );
  }

  Stream<TopicsState> _mapAddTopicToState(AddTopic event) async* {
    _topicsRepository.addNewTopic(event.topic);
  }

  Stream<TopicsState> _mapUpdateTopicToState(UpdateTopic event) async* {
    _topicsRepository.updateTopic(event.updatedTopic);
  }

  Stream<TopicsState> _mapDeleteTopicToState(DeleteTopic event) async* {
    _topicsRepository.deleteTopic(event.topic);
  }

  Stream<TopicsState> _mapClearCompletedToState() async* {
    final currentState = state;
    if(currentState is TopicsLoaded) {
      final List<Topic> completedTopics =
          currentState.topics.toList();
      completedTopics.forEach((completedTopic) {
        _topicsRepository.deleteTopic(completedTopic);
      });
    }
  }

  Stream<TopicsState> _mapTopicsUpdateToState(TopicsUpdated event) async* {
    yield TopicsLoaded(event.topics);
  }

  @override
  Future<Function> close() {
    _topicsSubscription?.cancel();
    return super.close();
  }
}
