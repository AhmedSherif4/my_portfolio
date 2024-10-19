part of '../../statics.dart';


@LazySingleton()
class GetTimeInAppUseCase extends BaseUseCase<TimeInAppModel, TimeInAppInputs> {
  final BaseStaticsRepository repository;

  GetTimeInAppUseCase({required this.repository});

  @override
  Future<Either<Failure, TimeInAppModel>> call(TimeInAppInputs parameter) async {
    return await repository.getTimeInApp(parameter);
  }
}

@LazySingleton()
class GetSubjectsForStaticsUseCase
    extends BaseUseCase<List<SubjectsEntity>, GetStaticsParam> {
  final BaseStaticsRepository repository;

  GetSubjectsForStaticsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SubjectsEntity>>> call(
      GetStaticsParam parameter) async {
    return await repository.getSubjects(subjectsParameters: parameter);
  }
}

@LazySingleton()
class GetLessonsStaticsUseCase
    extends BaseUseCase<LessonsStaticsModel, GetStaticsParam> {
  final BaseStaticsRepository repository;

  GetLessonsStaticsUseCase({required this.repository});

  @override
  Future<Either<Failure, LessonsStaticsModel>> call(
      GetStaticsParam parameter) async {
    return await repository.getLessonsStatics(parameters: parameter);
  }
}

@LazySingleton()
class GetLevelStaticsUseCase
    extends BaseUseCase<LevelStaticsModel, GetStaticsParam> {
  final BaseStaticsRepository repository;

  GetLevelStaticsUseCase({required this.repository});

  @override
  Future<Either<Failure, LevelStaticsModel>> call(
      GetStaticsParam parameter) async {
    return await repository.getLevelStatics(parameters: parameter);
  }
}

@LazySingleton()
class GetBestSubjectsUseCase
    extends BaseUseCase<List<BestSubjectsModel>, GetStaticsParam> {
  final BaseStaticsRepository repository;

  GetBestSubjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BestSubjectsModel>>> call(
      GetStaticsParam parameter) async {
    return await repository.getBestSubjects(parameters: parameter);
  }
}

class GetStaticsParam extends Equatable {
  final int systemId;
  final int stageId;
  final int termId;
  final int classRoomId;
  final int? pathId;
  final bool fromNafees;
  final List<dynamic> questions;

  final int? subjectId;
  final String? subjectName;
  final int? levelId;
  final int? childId;

  final String skillName;

  final bool isLesson;
  final List<SubjectsEntity> allSubjects;

  final UserEntity? userData;

  final String? classRoomName;
  final String? points;

  const GetStaticsParam(
      {this.allSubjects = const [],
      this.levelId,
      required this.systemId,
      required this.stageId,
      required this.termId,
      required this.classRoomId,
      this.pathId,
      this.subjectId = 0,
      this.subjectName = '',
      this.skillName = "",
      this.isLesson = true,
      this.childId,
      this.userData,
        this.questions = const [],
        this.classRoomName,
        this.points,


      this.fromNafees = false});

  GetStaticsParam copyWith({
    int? systemId,
    int? stageId,
    int? termId,
    int? classRoomId,
    int? subjectId,
    String? skillName,
    bool? isLesson,
    int? levelId,
    String? subjectName,
    List<SubjectsEntity>? allSubjects,
    int? childId,
    UserEntity? userData,
    int? pathId,
    bool? fromNafees,
    List<dynamic>? questions,
    String? classRoomName,
    String? points,
  }) {
    return GetStaticsParam(
      stageId: stageId ?? this.stageId,
      termId: termId ?? this.termId,
      classRoomId: classRoomId ?? this.classRoomId,
      subjectId: subjectId ?? this.subjectId,
      skillName: skillName ?? this.skillName,
      isLesson: isLesson ?? this.isLesson,
      levelId: levelId ?? this.levelId,
      subjectName: subjectName ?? this.subjectName,
      allSubjects: allSubjects ?? this.allSubjects,
      childId: childId ?? this.childId,
      userData: userData ?? this.userData,
      systemId: systemId ?? this.systemId,
      pathId: pathId ?? this.pathId,
      fromNafees: fromNafees ?? this.fromNafees,
      questions: questions ?? this.questions,
      classRoomName: classRoomName ?? this.classRoomName,
      points: points ?? this.points,
    );
  }

  @override
  List<Object?> get props => [
        systemId,
        pathId,
        stageId,
        termId,
        classRoomId,
        subjectId,
        skillName,
        isLesson,
        levelId,
        subjectName,
        allSubjects,
        childId,
        userData,
        fromNafees,
    questions,
    classRoomName
      ];
}
