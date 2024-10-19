part of '../../free_subjects_subscriptions.dart';

abstract class FreeSubjectsSubscriptionsEvent extends Equatable {
  const FreeSubjectsSubscriptionsEvent();

  @override
  List<Object> get props => [];
}

class GetSystemFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  const GetSystemFreeSubjectsEvent();
}

class GetStagesFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final int systemId;

  const GetStagesFreeSubjectsEvent(this.systemId);

  @override
  List<Object> get props => [systemId];
}

class GetClassRoomFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final GetClassRoomParameter getClassRoomParameter;

  const GetClassRoomFreeSubjectsEvent(this.getClassRoomParameter);

  @override
  List<Object> get props => [getClassRoomParameter];
}

class GetTermsFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final GetTermsParameters getTermsParameters;

  const GetTermsFreeSubjectsEvent(this.getTermsParameters);

  @override
  List<Object> get props => [getTermsParameters];
}

class GetPathsFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final GetPathParameters getPathsParameters;

  const GetPathsFreeSubjectsEvent(this.getPathsParameters);

  @override
  List<Object> get props => [getPathsParameters];
}

// class GetSubjectsFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
//   final FreeSubjectsSubscriptionsParameter freeSubjectsSubscriptionsParameter;
//
//   const GetSubjectsFreeSubjectsEvent(this.freeSubjectsSubscriptionsParameter);
//
//   @override
//   List<Object> get props => [freeSubjectsSubscriptionsParameter];
// }

class ChangeSystemFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final StudyingModel currentSystem;

  const ChangeSystemFreeSubjectsEvent(this.currentSystem);

  @override
  List<Object> get props => [currentSystem];
}

class ChangeStageFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final StudyingModel currentStage;

  const ChangeStageFreeSubjectsEvent(this.currentStage);

  @override
  List<Object> get props => [currentStage];
}

class ChangeClassRoomFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final StudyingModel currentClassRoom;

  const ChangeClassRoomFreeSubjectsEvent(this.currentClassRoom);

  @override
  List<Object> get props => [currentClassRoom];
}

class ChangeTermFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final StudyingModel currentTerm;

  const ChangeTermFreeSubjectsEvent(this.currentTerm);

  @override
  List<Object> get props => [currentTerm];
}

class ChangePathFreeSubjectsEvent extends FreeSubjectsSubscriptionsEvent {
  final StudyingModel currentPath;

  const ChangePathFreeSubjectsEvent(this.currentPath);

  @override
  List<Object> get props => [currentPath];
}
