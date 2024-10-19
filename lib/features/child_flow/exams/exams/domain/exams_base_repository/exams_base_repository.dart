part of '../../exams.dart';

abstract class ExamsBaseRepository {
  Future<Either<Failure, List<ExamEntity>>> getExamsForSpecificSubject(
      ExamsParameter parameter);
}
