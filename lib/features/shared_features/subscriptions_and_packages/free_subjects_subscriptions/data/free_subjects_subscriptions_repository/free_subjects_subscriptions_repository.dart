part of '../../free_subjects_subscriptions.dart';

@LazySingleton(as: FreeSubjectsSubscriptionsBaseRepository)
class FreeSubjectsSubscriptionsRepository
    implements FreeSubjectsSubscriptionsBaseRepository {
  final FreeSubjectsSubscriptionsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  FreeSubjectsSubscriptionsRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<SubjectsEntity>>> getSubjects(
      {required FreeSubjectsSubscriptionsParameter subjectsParameters}) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getSubjects(subjectsParameters: subjectsParameters),
    );
  }
}
