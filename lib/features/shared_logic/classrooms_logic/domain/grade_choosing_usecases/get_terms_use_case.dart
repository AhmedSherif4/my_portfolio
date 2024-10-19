import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_logic/classrooms_logic/data/models/studying_model.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../classrooms_logic.dart';

@LazySingleton()
class GetTermsUseCase
    extends BaseUseCase<List<StudyingModel>, GetTermsParameters> {
  final GradeChoosingBaseRepository repository;

  GetTermsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<StudyingModel>>> call(
      GetTermsParameters parameter) async {
    return await repository.getTerms(parameters: parameter);
  }
}
