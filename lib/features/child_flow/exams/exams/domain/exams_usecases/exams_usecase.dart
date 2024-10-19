part of '../../exams.dart';

@LazySingleton()
class ExamsUseCase extends BaseUseCase<List<ExamEntity>, ExamsParameter> {
  final ExamsBaseRepository repository;

  ExamsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ExamEntity>>> call(
      ExamsParameter parameter) async {
    return await repository.getExamsForSpecificSubject(
      parameter,
    );
  }
}
