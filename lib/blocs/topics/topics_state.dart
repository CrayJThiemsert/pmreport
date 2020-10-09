part of 'topics_bloc.dart';

@immutable
abstract class TopicsState extends Equatable {
  const TopicsState();

  @override
  List<Object> get props => [];
}

class TopicsLoading extends TopicsState {}

class TopicsLoaded extends TopicsState {
  final List<Topic> topics;
  
  const TopicsLoaded([this.topics = const []]);

  @override
  List<Object> get props => [topics];

  @override
  String toString() => 'TopicsLoaded { topics: $topics }';
}

class TopicsNotLoaded extends TopicsState {}

