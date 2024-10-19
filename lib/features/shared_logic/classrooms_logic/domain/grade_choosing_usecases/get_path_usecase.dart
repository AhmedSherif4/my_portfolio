import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/models/studying_model.dart';
import '../../classrooms_logic.dart';

@LazySingleton()
class GetPathsUseCase extends BaseUseCase<List<StudyingModel>, GetPathParameters> {
  final GradeChoosingBaseRepository repository;

  GetPathsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<StudyingModel>>> call(GetPathParameters parameter) async {
    return await repository.getPaths(parameters: parameter);
  }
}
