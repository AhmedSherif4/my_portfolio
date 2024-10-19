part of '../../subjects_shared_features.dart';


@LazySingleton(as: SubjectsSharedFeaturesBaseRepository)
class SubjectsSharedFeaturesRepository extends SubjectsSharedFeaturesBaseRepository {
  final BaseRepository baseRepository;
  final SubjectsSharedFeaturesRemoteDataSource remoteDataSource;
  final SubjectsSharedFeaturesLocalDataSource localeDataSource;

  SubjectsSharedFeaturesRepository({
    required this.baseRepository,
    required this.remoteDataSource,
    required this.localeDataSource,});

  @override
  Future<Either<Failure, List<SubjectsEntity>>>
  getSharedSubjects({required ParameterGoToQuestions subjectsParameters}) async {
    // if(subjectsParameters.subjectType == SubjectType.public) {
      ///...........get subjects from local data source.............
      // final allSubjectsLocal = await localeDataSource
      //     .getSharedSubjectsInLocalData(
      //   stageId: subjectsParameters.stageId,
      //   termId: subjectsParameters.termId,
      //   classRoomId: subjectsParameters.classRoomId,
      //   pathId: subjectsParameters.pathId,
      // );
      // if (allSubjectsLocal != null) {
      //   return Right(allSubjectsLocal);
      // } else {
        ///...........get subjects from remote data source.............
        // final jsonData = await baseRepository.checkExceptionForRemoteData(
        //     remoteDataSource.getSharedSubjects(
        //       subjectType: subjectsParameters.subjectType,
        //       subjectsParameters: subjectsParameters,
        //     )
        // );

      //   return jsonData.fold(
      //         (failure) => left(failure),
      //         (data) async{
      //       // await localeDataSource.saveSharedSubjectsInLocalData(
      //       //   stageId: subjectsParameters.stageId,
      //       //   termId: subjectsParameters.termId,
      //       //   classRoomId: subjectsParameters.classRoomId,
      //       //   pathId: subjectsParameters.pathId,
      //       //   data: data,
      //       // );
      //       return Right(data);
      //     },
      //   );
      // }
    // }else{
        ///...........get subjects from remote data source.............
        final jsonData = await baseRepository.checkExceptionForRemoteData(
            remoteDataSource.getSharedSubjects(
              subjectType: subjectsParameters.subjectType,
              subjectsParameters: subjectsParameters,
            )
        );

        return jsonData.fold(
              (failure) => left(failure),
              (data) async{
            return Right(data);
          },
        );
      }

    }

  // }

