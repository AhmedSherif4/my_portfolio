part of '../free_grade_subscriptions.dart';

class FreeGradeSubscriptionsState extends Equatable {
  final RequestStates getSystemState;
  final RequestStates getStagesState;
  final RequestStates getClassroomsState;

  final List<StudyingModel> systems;
  final List<StudyingModel> stages;
  final List<StudyingModel> classRooms;

  final StudyingModel currentSystem;
  final StudyingModel currentStage;

  const FreeGradeSubscriptionsState({
    this.getSystemState = RequestStates.initial,
    this.getStagesState = RequestStates.initial,
    this.getClassroomsState = RequestStates.initial,
    this.systems = const [],
    this.stages = const [],
    this.classRooms = const [],
    this.currentSystem = const StudyingModel(id: 0, name: 'Loading'),
    this.currentStage = const StudyingModel(id: 0, name: 'Loading'),
  });

  FreeGradeSubscriptionsState copyWith({
    RequestStates? getSystemState,
    RequestStates? getStagesState,
    RequestStates? getClassroomsState,
    List<StudyingModel>? systems,
    List<StudyingModel>? stages,
    List<StudyingModel>? classRooms,
    StudyingModel? currentSystem,
    StudyingModel? currentStage,
  }) {
    return FreeGradeSubscriptionsState(
      getSystemState: getSystemState ?? this.getSystemState,
      getStagesState: getStagesState ?? this.getStagesState,
      getClassroomsState: getClassroomsState ?? this.getClassroomsState,
      systems: systems ?? this.systems,
      stages: stages ?? this.stages,
      classRooms: classRooms ?? this.classRooms,
      currentSystem: currentSystem ?? this.currentSystem,
      currentStage: currentStage ?? this.currentStage,
    );
  }

  @override
  List<Object> get props => [
        getSystemState,
        getStagesState,
        getClassroomsState,
        systems,
        stages,
        classRooms,
        currentSystem,
        currentStage,
      ];
}
