part of '../../classrooms_logic.dart';

abstract class GradeChoosingEvent extends Equatable {
  const GradeChoosingEvent();
}

class GradeChoosingSubmittedEvent extends GradeChoosingEvent {
  final GradeChoosingParameters parameters;

  const GradeChoosingSubmittedEvent({required this.parameters});

  @override
  List<Object> get props => [parameters];
}


//Get
class GetSystemEvent extends GradeChoosingEvent{
  @override
  List<Object> get props => [];
}

class GetStagesEvent extends GradeChoosingEvent {
  final int systemId;

  const GetStagesEvent({required this.systemId});

  @override
  List<Object> get props => [systemId];
}

class GetClassRoomGradeEvent extends GradeChoosingEvent {
  final GetClassRoomParameter getClassRoomParameter;

  const GetClassRoomGradeEvent({required this.getClassRoomParameter});

  @override
  List<Object> get props => [getClassRoomParameter];
}

class GetTermsEvent extends GradeChoosingEvent {
  final GetTermsParameters getTermsParameters;

  const GetTermsEvent(this.getTermsParameters);

  @override
  List<Object> get props => [getTermsParameters];
}

class GetPathEvent extends GradeChoosingEvent {
  final GetPathParameters getPathParameters;
  const GetPathEvent(this.getPathParameters);
  @override
  List<Object> get props => [getPathParameters];
}


//Change
class ChangeSystemEvent extends GradeChoosingEvent {
  final StudyingModel currentSystem;

  const ChangeSystemEvent(this.currentSystem);

  @override
  List<Object> get props => [currentSystem];
}

class ChangeStageEvent extends GradeChoosingEvent {
  final StudyingModel currentStage;

  const ChangeStageEvent(this.currentStage);

  @override
  List<Object> get props => [currentStage];
}

class ChangeClassRoomEvent extends GradeChoosingEvent {
  final StudyingModel currentClassRoom;

  const ChangeClassRoomEvent(this.currentClassRoom);

  @override
  List<Object> get props => [currentClassRoom];
}

class ChangeTermEvent extends GradeChoosingEvent {
  final StudyingModel currentTerm;

  const ChangeTermEvent(this.currentTerm);

  @override
  List<Object> get props => [currentTerm];
}

class ChangePathEvent extends GradeChoosingEvent {
  final StudyingModel currentPath;
  const ChangePathEvent(this.currentPath);
  @override
  List<Object> get props => [currentPath];
}
class ChangeClassroomPathEvent extends GradeChoosingEvent {
  final PathsInClassroomModel currentPath;
  const ChangeClassroomPathEvent(this.currentPath);
  @override
  List<Object> get props => [currentPath];
}

