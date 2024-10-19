part of '../../collections.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class GetCollectionsEvent extends CollectionsEvent {
  final ParameterGoToQuestions parameters;

  const GetCollectionsEvent({required this.parameters});

  @override
  List<Object> get props => [parameters];
}

class UpdateCollectionsEvent extends CollectionsEvent {
  final ParameterUpdatePoints parameters;

  const UpdateCollectionsEvent({required this.parameters});

  @override
  List<Object> get props => [parameters];
}
