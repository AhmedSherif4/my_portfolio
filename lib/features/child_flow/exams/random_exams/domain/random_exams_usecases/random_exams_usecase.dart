
part of'../../random_exams.dart';

@LazySingleton()
class AllRandomExamsUseCase extends BaseUseCase<List<AllRandomExamEntityOutputs>, AllRandomExamInputs> {
  final RandomExamsBaseRepository repository;

  AllRandomExamsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AllRandomExamEntityOutputs>>> call(
      AllRandomExamInputs parameter) async {
    return await repository.getRandomExamsForSpecificSubject(parameter);
  }
}
