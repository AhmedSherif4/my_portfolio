import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../classrooms_logic.dart';
import '../../data/models/studying_model.dart';

@LazySingleton()
class GetStagesUseCase extends BaseUseCase<List<StudyingModel>, int> {
  final GradeChoosingBaseRepository repository;

  GetStagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<StudyingModel>>> call(int parameter) async {
    return await repository.getStages(systemId: parameter);
  }
}
