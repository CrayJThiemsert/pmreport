part of 'parts_bloc.dart';

@immutable
abstract class PartsState extends Equatable {
  const PartsState();

  @override
  List<Object> get props => [];
}

class PartsLoading extends PartsState {}

class PartsLoaded extends PartsState {
  final List<Part> parts;
  
  const PartsLoaded([this.parts = const []]);

  @override
  List<Object> get props => [parts];

  @override
  String toString() => 'PartsLoaded { parts: $parts }';
}

class PartsNotLoaded extends PartsState {}

