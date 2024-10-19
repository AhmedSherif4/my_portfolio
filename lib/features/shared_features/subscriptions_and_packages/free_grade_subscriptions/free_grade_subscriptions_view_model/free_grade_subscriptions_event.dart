part of '../free_grade_subscriptions.dart';

abstract class FreeGradeSubscriptionsEvent extends Equatable {
  const FreeGradeSubscriptionsEvent();

  @override
  List<Object> get props => [];
}

class GetSystemsFreeGrade extends FreeGradeSubscriptionsEvent {
  const GetSystemsFreeGrade();

  @override
  List<Object> get props => [];
}

class GetStagesFreeGrade extends FreeGradeSubscriptionsEvent {
  final int systemId;
  const GetStagesFreeGrade({required this.systemId});

  @override
  List<Object> get props => [systemId];
}

class GetClassroomsFreeGrade extends FreeGradeSubscriptionsEvent {
  final GetClassRoomParameter getClassRoomParameters;
  const GetClassroomsFreeGrade({required this.getClassRoomParameters});

  @override
  List<Object> get props => [getClassRoomParameters];
}

class ChangeSystemFreeGrade extends FreeGradeSubscriptionsEvent {
  final StudyingModel currentSystem;
  const ChangeSystemFreeGrade(this.currentSystem);

  @override
  List<Object> get props => [currentSystem];
}

class ChangeStagesFreeGrade extends FreeGradeSubscriptionsEvent {
  final StudyingModel currentStage;

  const ChangeStagesFreeGrade(this.currentStage);

  @override
  List<Object> get props => [currentStage];
}

//? => get stages, then get first stage classes as init
//? => when select stage, get classes of this stage
//? => when get classes, put it in select items widget  