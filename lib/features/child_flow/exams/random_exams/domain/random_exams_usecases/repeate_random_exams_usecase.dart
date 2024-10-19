part of'../../random_exams.dart';

@LazySingleton()
class RepeatRandomExamsUseCase extends BaseUseCase<RandomExamEntityOutputs, int> {
  final RandomExamsBaseRepository repository;

  RepeatRandomExamsUseCase({required this.repository});

  @override
  Future<Either<Failure, RandomExamEntityOutputs>> call(
      int parameter) async {
    return await repository.repeatRandomExamsForSpecificSubject(
      parameter,
    );
  }
}
