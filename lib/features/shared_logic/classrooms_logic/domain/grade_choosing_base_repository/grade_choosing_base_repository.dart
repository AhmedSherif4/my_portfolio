part of '../../classrooms_logic.dart';

abstract class GradeChoosingBaseRepository {
  Future<Either<Failure, GradeChoosingModel>> gradeChoosing({
    required GradeChoosingParameters parameters,
  });

  Future<Either<Failure, List<StudyingModel>>> getSystemTypes();

  Future<Either<Failure, List<StudyingModel>>> getStages({
    required int systemId,
});

  Future<Either<Failure, List<StudyingModel>>> getClassRoom({
    required GetClassRoomParameter getClassRoomParameter,
  });

  Future<Either<Failure, List<StudyingModel>>> getTerms({
    required GetTermsParameters parameters,
  });

  Future<Either<Failure, List<StudyingModel>>> getPaths({
    required GetPathParameters parameters,
  });
}
class GetClassRoomParameter extends Equatable{
  final int stageId;

  const GetClassRoomParameter({
    required this.stageId,
  });
  @override
  List<Object?> get props => [stageId];
}

class GetTermsParameters extends Equatable {
  final int systemId;
  final int stageId;
  final int classRoomId;

  const GetTermsParameters({
    required this.systemId,
    required this.stageId,
    required this.classRoomId,
  });

  @override
  List<Object> get props => [stageId, classRoomId,systemId];
}

class GetPathParameters extends Equatable {
  final int systemId;
  final int stageId;
  final int classRoomId;
  final int termId;

  const GetPathParameters({
    required this.systemId,
    required this.stageId,
    required this.classRoomId,
    required this.termId,
  });

  @override
  List<Object> get props => [stageId, classRoomId,systemId,termId];
}
