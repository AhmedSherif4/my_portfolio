part of '../../free_subjects_subscriptions.dart';

abstract class FreeSubjectsSubscriptionsBaseRepository {
  Future<Either<Failure, List<SubjectsEntity>>> getSubjects(
      {required FreeSubjectsSubscriptionsParameter subjectsParameters});
}
