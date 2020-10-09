part of 'topics_bloc.dart';

@immutable
abstract class TopicsEvent extends Equatable {
  const TopicsEvent();

  @override
  List<Object> get props => [];
}

class LoadTopics extends TopicsEvent {
  final String categoryUid;
  final String partUid;

  const LoadTopics(this.categoryUid, this.partUid);

  @override
  List<Object> get props => [categoryUid, partUid];

  @override
  String toString() => 'LoadTopics { categoryUid: $categoryUid, partUid: $partUid }';
}

class AddTopic extends TopicsEvent {
  final Topic topic;
  
  const AddTopic(this.topic);

  @override
  List<Object> get props => [topic];

  @override
  String toString() => 'AddTopic { topic: $topic }';
}

class UpdateTopic extends TopicsEvent {
  final Topic updatedTopic;

  const UpdateTopic(this.updatedTopic);

  @override
  List<Object> get props => [updatedTopic];

  @override
  String toString() => 'UpdateTopic { updatedTopic: $updatedTopic }';
}

class DeleteTopic extends TopicsEvent {
  final Topic topic;

  const DeleteTopic(this.topic);

  @override
  List<Object> get props => [topic];

  @override
  String toString() => 'DeleteTopic { topic: $topic }';
}

class ClearCompleted extends TopicsEvent {}

class TopicsUpdated extends TopicsEvent {
  final List<Topic> topics;

  const TopicsUpdated(this.topics);

  @override
  List<Object> get props => [topics];
}
