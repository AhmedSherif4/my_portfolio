
part of'../../random_exams.dart';

abstract class RandomExamsBaseRepository {
  Future<Either<Failure, RandomExamEntityOutputs>> createRandomExamsForSpecificSubject(
      CreateRandomExamInputs createRandomExamInputs);
  Future<Either<Failure, RandomExamEntityOutputs>> repeatRandomExamsForSpecificSubject(
      int examID);
  Future<Either<Failure, List<AllRandomExamEntityOutputs>>> getRandomExamsForSpecificSubject(AllRandomExamInputs allRandomExamInputs);
  Future<Either<Failure, String>> getRandomExamsAnswersForSpecificSubject(RandomExamQuestionsAnswersInputs randomExamQuestionsAnswersInputs);
}
