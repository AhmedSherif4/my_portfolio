import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/models/studying_model.dart';
import '../../classrooms_logic.dart';

@LazySingleton()
class GetSystemTypesUseCase extends BaseUseCase<List<StudyingModel>, NoParameter> {
  final GradeChoosingBaseRepository repository;

  GetSystemTypesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<StudyingModel>>> call(parameter) async {
    return await repository.getSystemTypes();
  }
}
