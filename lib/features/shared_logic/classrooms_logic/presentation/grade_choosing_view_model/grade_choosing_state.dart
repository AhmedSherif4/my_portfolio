part of '../../classrooms_logic.dart';

class GradeChoosingState extends Equatable {
  final RequestStates gradeChoosingSubmittedStates;
  final String gradeChoosingMessage;

  final RequestStates getSystemState;
  final RequestStates getStagesState;
  final RequestStates getClassRoomsState;
  final RequestStates getTermsState;
  final RequestStates getPathsState;
  final List<StudyingModel> systems;
  final List<StudyingModel> stages;
  final List<StudyingModel> classRooms;
  final List<StudyingModel> terms;
  final List<StudyingModel> paths;
  final List<PathsInClassroomModel> classroomPaths;

  final GradeStates changeSystemState;
  final GradeStates changeStageState;
  final GradeStates changeClassRoomState;
  final GradeStates changeTermState;
  final GradeStates changePathState;
  final GradeStates changeClassroomPathState;
  final StudyingModel currentSystem;
  final StudyingModel currentStage;
  final StudyingModel currentClassRoom;
  final StudyingModel currentTerm;
  final StudyingModel currentPath;
  final PathsInClassroomModel currentClassroomPath;
  final bool haveSystem;

  const GradeChoosingState({
    this.gradeChoosingSubmittedStates = RequestStates.initial,
    this.gradeChoosingMessage = '',
    this.getStagesState = RequestStates.initial,
    this.getClassRoomsState = RequestStates.initial,
    this.getTermsState = RequestStates.initial,
    this.stages = const [],
    this.classRooms = const [],
    this.terms = const [],
    this.currentStage = const StudyingModel(id: 0, name: 'Loading'),
    this.changeStageState = GradeStates.init,
    this.changeClassRoomState = GradeStates.init,
    this.changeTermState = GradeStates.init,
    this.currentClassRoom = const StudyingModel(id: 0, name: 'Loading'),
    this.currentTerm = const StudyingModel(id: 0, name: 'Loading'),
    this.currentSystem = const StudyingModel(id: 0, name: 'Loading'),
    this.getSystemState = RequestStates.initial,
    this.systems = const [],
    this.changeSystemState = GradeStates.init,
    this.paths = const [],
    this.changePathState = GradeStates.init,
    this.currentPath = const StudyingModel(id: 0, name: 'Loading'),
    this.getPathsState = RequestStates.initial,
    this.classroomPaths = const [],
    this.currentClassroomPath =
        const PathsInClassroomModel(pathId: -1, pathName: 'Loading'),
    this.changeClassroomPathState = GradeStates.init,
    this.haveSystem = false,
  });

  GradeChoosingState copyWith({
    RequestStates? gradeChoosingSubmittedStates,
    String? gradeChoosingMessage,
    RequestStates? getStagesState,
    RequestStates? getClassRoomsState,
    RequestStates? getTermsState,
    List<StudyingModel>? stages,
    List<StudyingModel>? classRooms,
    List<StudyingModel>? terms,
    GradeStates? changeStageState,
    GradeStates? changeClassRoomState,
    GradeStates? changeTermState,
    StudyingModel? currentStage,
    StudyingModel? currentClassRoom,
    StudyingModel? currentTerm,
    StudyingModel? currentSystem,
    RequestStates? getSystemState,
    List<StudyingModel>? systems,
    GradeStates? changeSystemState,
    List<StudyingModel>? paths,
    List<PathsInClassroomModel>? classroomPaths,
    GradeStates? changePathState,
    GradeStates? changeClassroomPathState,
    PathsInClassroomModel? currentClassroomPath,
    StudyingModel? currentPath,
    RequestStates? getPathsState,
    bool? haveSystem,
  }) {
    return GradeChoosingState(
      gradeChoosingMessage: gradeChoosingMessage ?? this.gradeChoosingMessage,
      gradeChoosingSubmittedStates:
          gradeChoosingSubmittedStates ?? this.gradeChoosingSubmittedStates,
      getStagesState: getStagesState ?? this.getStagesState,
      getClassRoomsState: getClassRoomsState ?? this.getClassRoomsState,
      getTermsState: getTermsState ?? this.getTermsState,
      stages: stages ?? this.stages,
      classRooms: classRooms ?? this.classRooms,
      terms: terms ?? this.terms,
      currentStage: currentStage ?? this.currentStage,
      changeStageState: changeStageState ?? this.changeStageState,
      changeTermState: changeTermState ?? this.changeTermState,
      changeClassRoomState: changeClassRoomState ?? this.changeClassRoomState,
      currentClassRoom: currentClassRoom ?? this.currentClassRoom,
      currentTerm: currentTerm ?? this.currentTerm,
      currentSystem: currentSystem ?? this.currentSystem,
      getSystemState: getSystemState ?? this.getSystemState,
      systems: systems ?? this.systems,
      changeSystemState: changeSystemState ?? this.changeSystemState,
      paths: paths ?? this.paths,
      changePathState: changePathState ?? this.changePathState,
      currentPath: currentPath ?? this.currentPath,
      getPathsState: getPathsState ?? this.getPathsState,
      classroomPaths: classroomPaths ?? this.classroomPaths,
      currentClassroomPath: currentClassroomPath ?? this.currentClassroomPath,
      changeClassroomPathState:
          changeClassroomPathState ?? this.changeClassroomPathState,
      haveSystem: haveSystem ?? this.haveSystem,
    );
  }

  @override
  List<Object> get props => [
        gradeChoosingSubmittedStates,
        gradeChoosingMessage,
        getStagesState,
        getClassRoomsState,
        getTermsState,
        stages,
        classRooms,
        terms,
        changeStageState,
        changeClassRoomState,
        changeTermState,
        currentStage,
        currentClassRoom,
        currentTerm,
        currentSystem,
        getSystemState,
        systems,
        changeSystemState,
        paths,
        changePathState,
        currentPath,
        getPathsState,
        classroomPaths,
        currentClassroomPath,
        changeClassroomPathState,
        haveSystem
      ];
}
