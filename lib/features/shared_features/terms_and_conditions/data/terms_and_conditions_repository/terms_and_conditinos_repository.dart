part of '../../terms_and_conditions.dart';



@LazySingleton(
  as: TermsAndConditionsBaseRepository,
)
class TermsAndConditionsRepository implements TermsAndConditionsBaseRepository {
  final TermsAndConditionsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  final GetTermsAndConditionsLocalDataSource localDataSource;

  TermsAndConditionsRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, TermsAndConditionsEntity>>
      getTermAndCondition() async {
    final termsAndCondition = await localDataSource.getTermsAndConditions();
    if (termsAndCondition != null) {
      return Right(termsAndCondition);
    }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getTermsAndCondition(),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {
        await localDataSource.saveTermsAndCondition(data: data);
        return Right(data);
      },
    );
  }
}
