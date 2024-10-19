
part of'../../random_exams.dart';

@LazySingleton()
class RandomExamsQuestionsAnswersUseCase extends BaseUseCase<String, RandomExamQuestionsAnswersInputs> {
  final RandomExamsBaseRepository repository;

  RandomExamsQuestionsAnswersUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      RandomExamQuestionsAnswersInputs parameter) async {
    return await repository.getRandomExamsAnswersForSpecificSubject(parameter);
  }
}
