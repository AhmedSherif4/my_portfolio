part of '../../free_subjects_subscriptions.dart';

@LazySingleton()
class GetSubjectsFreeSubjectsSubscriptionsUseCase extends BaseUseCase<
    List<SubjectsEntity>, FreeSubjectsSubscriptionsParameter> {
  final FreeSubjectsSubscriptionsBaseRepository repository;

  GetSubjectsFreeSubjectsSubscriptionsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SubjectsEntity>>> call(
      FreeSubjectsSubscriptionsParameter parameter) async {
    return await repository.getSubjects(
      subjectsParameters:  parameter,
    );
  }
}
