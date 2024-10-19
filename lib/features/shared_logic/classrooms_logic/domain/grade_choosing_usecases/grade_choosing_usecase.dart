part of '../../classrooms_logic.dart';

@LazySingleton()
class GradeChoosingUseCase
    extends BaseUseCase<GradeChoosingModel, GradeChoosingParameters> {
  final GradeChoosingBaseRepository repository;

  GradeChoosingUseCase({required this.repository});

  @override
  Future<Either<Failure, GradeChoosingModel>> call(
      GradeChoosingParameters parameter) async {
    return await repository.gradeChoosing(parameters: parameter);
  }
}

class GradeChoosingParameters extends Equatable {
  final int systemId;
  final int stageId;
  final int classRoomId;
  final int termId;
  final int? pathId;

  const GradeChoosingParameters({
    required this.systemId,
    required this.stageId,
    required this.classRoomId,
    required this.termId,
    this.pathId,
  });

  @override
  List<Object> get props => [
        systemId,
        stageId,
        classRoomId,
        termId,
        pathId ?? 0,
      ];
}
