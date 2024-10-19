part of '../../add_child.dart';


@LazySingleton(
  as: InstitutionAddChildRepository,
)
class InstitutionAddChildRepositoryImpl
    implements InstitutionAddChildRepository {
  final InstitutionAddChildRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  InstitutionAddChildRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, String>> institutionAddChild(
      {required InstitutionAddChildParameter addChildParameter}) async {
    final data = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.institutionAddChild(
        addChildParameter: addChildParameter,
      ),
    );
    return data.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
