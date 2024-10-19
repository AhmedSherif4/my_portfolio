part of '../../subjects_shared_features.dart';


@LazySingleton()
class GetSharedSubjectsUseCase
    extends BaseUseCase<List<SubjectsEntity>, ParameterGoToQuestions> {
  final SubjectsSharedFeaturesBaseRepository repository;

  GetSharedSubjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SubjectsEntity>>> call(
      ParameterGoToQuestions parameter) async {
    return await repository.getSharedSubjects(
        subjectsParameters: parameter);
  }
}


