import 'package:equatable/equatable.dart';

import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../child_flow/home/domain/home_entities/subjects_entity.dart';
import '../../../domain/entity/child_subscriptions_studying_entity.dart';


class SubscriptionSystemsState extends Equatable {
  final RequestStates getSystemState;
  final RequestStates getStagesState;
  final RequestStates getClassRoomsState;
  final RequestStates getTermsState;
  final RequestStates getPathsState;
  final RequestStates getSubjectsState;

  final List<ChildSubscriptionsStudyingEntity> systems;
  final List<ChildSubscriptionsStudyingEntity> stages;
  final List<ChildSubscriptionsStudyingEntity> classRooms;
  final List<ChildSubscriptionsStudyingEntity> terms;
  final List<ChildSubscriptionsStudyingEntity> paths;
  final List<SubjectsEntity> subjects;
  final SubjectsEntity currentSubject;
  final ChildSubscriptionsStudyingEntity currentSystem;
  final ChildSubscriptionsStudyingEntity currentStage;
  final ChildSubscriptionsStudyingEntity currentClassRoom;
  final ChildSubscriptionsStudyingEntity currentTerm;
  final ChildSubscriptionsStudyingEntity currentPath;
  final bool haveSystem;

  const SubscriptionSystemsState({
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
    this.haveSystem = false,
    this.currentSystem =
        const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
    this.currentStage =
        const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
    this.currentClassRoom =
        const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
    this.currentTerm =
        const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
    this.currentPath =
        const ChildSubscriptionsStudyingEntity(id: 0, name: 'Loading'),
    this.currentSubject = const SubjectsEntity(
      subjectId: 0,
      subjectName: 'Loading',
      isHaveUnit: false,
      itemColor: '',
      subjectImg: '',
      price: 1,
      oldPrice: 1,
      classroomId: 0,
      termId: 0,
      stageId: 0,
    ),
  });

  SubscriptionSystemsState copyWith({
    RequestStates? getSystemState,
    RequestStates? getStagesState,
    RequestStates? getClassRoomsState,
    RequestStates? getTermsState,
    RequestStates? getPathsState,
    RequestStates? getSubjectsState,
    List<ChildSubscriptionsStudyingEntity>? systems,
    List<ChildSubscriptionsStudyingEntity>? stages,
    List<ChildSubscriptionsStudyingEntity>? classRooms,
    List<ChildSubscriptionsStudyingEntity>? terms,
    List<ChildSubscriptionsStudyingEntity>? paths,
    List<SubjectsEntity>? subjects,
    ChildSubscriptionsStudyingEntity? currentSystem,
    ChildSubscriptionsStudyingEntity? currentStage,
    ChildSubscriptionsStudyingEntity? currentClassRoom,
    ChildSubscriptionsStudyingEntity? currentTerm,
    ChildSubscriptionsStudyingEntity? currentPath,
    bool? haveSystem,
  }) {
    return SubscriptionSystemsState(
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
        haveSystem: haveSystem ?? this.haveSystem,
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
        haveSystem,
      ];
}
