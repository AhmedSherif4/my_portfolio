part of'../../random_exams.dart';

@LazySingleton()
class CreateRandomExamsUseCase extends BaseUseCase<RandomExamEntityOutputs, CreateRandomExamInputs> {
  final RandomExamsBaseRepository repository;

  CreateRandomExamsUseCase({required this.repository});

  @override
  Future<Either<Failure, RandomExamEntityOutputs>> call(
      CreateRandomExamInputs parameter) async {
    return await repository.createRandomExamsForSpecificSubject(
      parameter,
    );
  }
}
