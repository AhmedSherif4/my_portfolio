part of '../free_term_subscriptions.dart';

abstract class FreeTermSubscriptionsEvent extends Equatable {
  const FreeTermSubscriptionsEvent();

  @override
  List<Object> get props => [];
}

class GetSystemFreeTermSubscriptionsEvent extends FreeTermSubscriptionsEvent {
  const GetSystemFreeTermSubscriptionsEvent();
@override
  List<Object> get props => [];
}

class GetStagesFreeTermEvent extends FreeTermSubscriptionsEvent {
  final int systemId;
  const GetStagesFreeTermEvent(this.systemId);
  @override
  List<Object> get props => [systemId];
}

class GetClassRoomFreeTermEvent extends FreeTermSubscriptionsEvent {
  final GetClassRoomParameter getClassRoomParameter;

  const GetClassRoomFreeTermEvent(this.getClassRoomParameter);

  @override
  List<Object> get props => [getClassRoomParameter];
}

class GetTermsFreeTermEvent extends FreeTermSubscriptionsEvent {
  final GetTermsParameters getTermsParameters;

  const GetTermsFreeTermEvent(this.getTermsParameters);

  @override
  List<Object> get props => [getTermsParameters];
}

class GetPathsFreeTermEvent extends FreeTermSubscriptionsEvent {
  final GetPathParameters getPathsParameters;
  const GetPathsFreeTermEvent(this.getPathsParameters);
  @override
  List<Object> get props => [getPathsParameters];
}

class ChangeSystemFreeTermEvent extends FreeTermSubscriptionsEvent {
  final StudyingModel currentSystem;

  const ChangeSystemFreeTermEvent(this.currentSystem);

  @override
  List<Object> get props => [currentSystem];
}

class ChangeStageFreeTermEvent extends FreeTermSubscriptionsEvent {
  final StudyingModel currentStage;

  const ChangeStageFreeTermEvent(this.currentStage);

  @override
  List<Object> get props => [currentStage];
}

class ChangeClassRoomFreeTermEvent extends FreeTermSubscriptionsEvent {
  final StudyingModel currentClassRoom;

  const ChangeClassRoomFreeTermEvent(this.currentClassRoom);

  @override
  List<Object> get props => [currentClassRoom];
}

class ChangeTermFreeTermEvent extends FreeTermSubscriptionsEvent {
  final StudyingModel currentTerm;

  const ChangeTermFreeTermEvent(this.currentTerm);

  @override
  List<Object> get props => [currentTerm];
}
