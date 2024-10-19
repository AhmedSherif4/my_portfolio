part of '../../classrooms_logic.dart';

@LazySingleton(as: GradeChoosingBaseRepository)
class GradeChoosingRepository implements GradeChoosingBaseRepository {
  final GradeChoosingRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GradeChoosingRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, GradeChoosingModel>> gradeChoosing({
    required GradeChoosingParameters parameters,
  }) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.gradeChoosing(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) => right(data),
    );
  }


  @override
  Future<Either<Failure, List<StudyingModel>>> getSystemTypes() async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getSystemsId(),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, List<StudyingModel>>> getStages({required int systemId}) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getStages(systemId: systemId),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, List<StudyingModel>>> getClassRoom({
    required GetClassRoomParameter getClassRoomParameter,
  }) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getClassRoom(getClassRoomParameter: getClassRoomParameter),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) => right(data),
    );
  }



  @override
  Future<Either<Failure, List<StudyingModel>>> getTerms({
    required GetTermsParameters parameters,
  }) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getTerms(parameters: parameters),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, List<StudyingModel>>> getPaths({required GetPathParameters parameters}) async {
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getPaths(parameters: parameters),
    );
    return jsonData.fold(
          (failure) => left(failure),
          (data) => right(data),
    );
  }



}
