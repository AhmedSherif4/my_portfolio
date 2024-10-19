part of '../../rank.dart';

abstract class RankRemoteDataSource {
  Future<RankEntity> getRankStage(RankParameters rankParameters);

  Future<RankEntity> getRankClassroom(RankParameters rankParameters);

  Future<RankEntity> getRankTerm(RankParameters rankParameters);

  Future<RankEntity> getRankSubject(RankParameters rankParameters);
}

@LazySingleton(as: RankRemoteDataSource)
class RankRemoteDataSourceImpl implements RankRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  RankRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<RankEntity> getRankStage(RankParameters parameters) async {
    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource.postData(
            url: '${EndPoints.rankStage}?page=${parameters.pageNumber}',
            body: {
              'system_id': parameters.systemID,
              'stage_id': parameters.stageID,
            },
          )
        : await baseRemoteDataSource.postData(
            url: '${EndPoints.parentRankStage}?page=${parameters.pageNumber}',
            body: {
              'system_id': parameters.systemID,
              'stage_id': parameters.stageID,
              // 'stage_id': parameters.stageID,
            },
          );
    return RankModel.fromJson(response);
  }

  @override
  Future<RankEntity> getRankClassroom(RankParameters parameters) async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild()
          ? '${EndPoints.rankStage}?page=${parameters.pageNumber}'
          : AppReference.userIsParent()
              ? '${EndPoints.parentRankStage}?page=${parameters.pageNumber}'
              : '${EndPoints.institutionRankStage}?page=${parameters.pageNumber}',
      body: {
        'system_id': parameters.systemID,
        'stage_id': parameters.stageID,
        // 'classroom_id': parameters.classroomID,
      },
    );
    return RankModel.fromJson(response['data']);
  }

  @override
  Future<RankEntity> getRankTerm(RankParameters parameters) async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild()
          ? '${EndPoints.rankTerm}?page=${parameters.pageNumber}'
          : AppReference.userIsParent()
              ? '${EndPoints.parentRankTerm}?page=${parameters.pageNumber}'
              : '${EndPoints.institutionRankTerm}?page=${parameters.pageNumber}',
      body: {
        'system_id': parameters.systemID,
        'stage_id': parameters.stageID,
        'path_id': parameters.pathID,
        'classroom_id': parameters.classroomID,
        'term_id': parameters.termID,
      },
    );
    return RankModel.fromJson(response['data']);
  }

  @override
  Future<RankEntity> getRankSubject(RankParameters parameters) async {
    final response = await baseRemoteDataSource.postData(
      url: AppReference.userIsChild()
          ? '${EndPoints.rankSubject}?page=${parameters.pageNumber}'
          : AppReference.userIsParent()
              ? '${EndPoints.parentRankSubject}?page=${parameters.pageNumber}'
              : '${EndPoints.institutionRankSubject}?page=${parameters.pageNumber}',
      body: {
        'system_id': parameters.systemID,
        'stage_id': parameters.stageID,
        'classroom_id': parameters.classroomID,
        'term_id': parameters.termID,
        'path_id': parameters.pathID,
        'subject_id': parameters.subjectID,
      },
    );
    return RankModel.fromJson(response['data']);
  }
}

class RankParameters extends Equatable {
  final int systemID;
  final int stageID;
  final int? classroomID;
  final int? subjectID;
  final int? termID;
  final int? pathID;
  final int pageNumber;

  const RankParameters({
    required this.stageID,
    this.classroomID,
    this.subjectID,
    this.termID,
    required this.pageNumber,
    required this.systemID,
    this.pathID,
  });

  @override
  List<Object?> get props => [
        stageID,
        classroomID,
        subjectID,
        termID,
        pageNumber,
        systemID,
        pathID,
      ];
}
