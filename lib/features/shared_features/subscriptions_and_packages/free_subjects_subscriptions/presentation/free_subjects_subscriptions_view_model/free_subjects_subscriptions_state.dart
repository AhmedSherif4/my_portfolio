part of '../../free_subjects_subscriptions.dart';

class FreeSubjectsSubscriptionsState extends Equatable {
  final RequestStates getSystemState;
  final RequestStates getStagesState;
  final RequestStates getClassRoomsState;
  final RequestStates getTermsState;
  final RequestStates getPathsState;
  final RequestStates getSubjectsState;

  final List<StudyingModel> systems;
  final List<StudyingModel> stages;
  final List<StudyingModel> classRooms;
  final List<StudyingModel> terms;
  final List<StudyingModel> paths;
  final List<SubjectsEntity> subjects;

  final StudyingModel currentSystem;
  final StudyingModel currentStage;
  final StudyingModel currentClassRoom;
  final StudyingModel currentTerm;
  final StudyingModel currentPath;

  const FreeSubjectsSubscriptionsState({
    this.getSystemState = RequestStates.initial,
    this.getStagesState = RequestStates.initial,
    this.getClassRoomsState = RequestStates.initial,
    this.getTermsState = RequestStates.initial,
    this.getSubjectsState = RequestStates.initial,
    this.getPathsState = RequestStates.initial,
    this.systems = const [],
    this.stages = const [],
    this.classRooms = const [],
    this.terms = const [],
    this.paths = const [],
    this.subjects = const [],
    this.currentSystem = const StudyingModel(id: 0, name: 'Loading'),
    this.currentStage = const StudyingModel(id: 0, name: 'Loading'),
    this.currentClassRoom = const StudyingModel(id: 0, name: 'Loading'),
    this.currentTerm = const StudyingModel(id: 0, name: 'Loading'),
    this.currentPath = const StudyingModel(id: 0, name: 'Loading'),
  });

  FreeSubjectsSubscriptionsState copyWith({
    RequestStates? getSystemState,
    RequestStates? getStagesState,
    RequestStates? getClassRoomsState,
    RequestStates? getTermsState,
    RequestStates? getPathsState,
    RequestStates? getSubjectsState,
    List<StudyingModel>? systems,
    List<StudyingModel>? stages,
    List<StudyingModel>? classRooms,
    List<StudyingModel>? terms,
    List<StudyingModel>? paths,
    List<SubjectsEntity>? subjects,
    StudyingModel? currentSystem,
    StudyingModel? currentStage,
    StudyingModel? currentClassRoom,
    StudyingModel? currentTerm,
    StudyingModel? currentPath,
  }) {
    return FreeSubjectsSubscriptionsState(
      getSystemState: getSystemState ?? this.getSystemState,
      getStagesState: getStagesState ?? this.getStagesState,
      getClassRoomsState: getClassRoomsState ?? this.getClassRoomsState,
      getTermsState: getTermsState ?? this.getTermsState,
      getPathsState: getPathsState ?? this.getPathsState,
      getSubjectsState: getSubjectsState ?? this.getSubjectsState,
      systems: systems ?? this.systems,
      stages: stages ?? this.stages,
      classRooms: classRooms ?? this.classRooms,
      terms: terms ?? this.terms,
      paths: paths ?? this.paths,
      subjects: subjects ?? this.subjects,
      currentSystem: currentSystem ?? this.currentSystem,
      currentStage: currentStage ?? this.currentStage,
      currentClassRoom: currentClassRoom ?? this.currentClassRoom,
      currentTerm: currentTerm ?? this.currentTerm,
      currentPath: currentPath ?? this.currentPath,
    );
  }

  @override
  List<Object> get props => [
        getSystemState,
        getStagesState,
        getClassRoomsState,
        getTermsState,
        getPathsState,
        getSubjectsState,
        systems,
        stages,
        classRooms,
        terms,
        paths,
        subjects,
        currentSystem,
        currentStage,
        currentClassRoom,
        currentTerm,
        currentPath,
      ];
}
