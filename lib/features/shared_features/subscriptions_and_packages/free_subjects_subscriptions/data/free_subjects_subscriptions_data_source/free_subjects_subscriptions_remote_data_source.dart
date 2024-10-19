part of '../../free_subjects_subscriptions.dart';

abstract class FreeSubjectsSubscriptionsRemoteDataSource {
  Future<List<SubjectsEntity>> getSubjects(
      {required FreeSubjectsSubscriptionsParameter subjectsParameters});
}

@LazySingleton(as: FreeSubjectsSubscriptionsRemoteDataSource)
class FreeSubjectsSubscriptionsRemoteDataSourceImpl
    implements FreeSubjectsSubscriptionsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  FreeSubjectsSubscriptionsRemoteDataSourceImpl(
      {required this.baseRemoteDataSource});

  @override
  Future<List<SubjectsEntity>> getSubjects(
      {required FreeSubjectsSubscriptionsParameter subjectsParameters}) async {
    final response =
        await baseRemoteDataSource.postData(url: EndPoints.subjects, body: {
      // 'stage_id': subjectsParameters.stageId,
      // 'classroom_id': subjectsParameters.classRoomId,
      'term_id': subjectsParameters.termId,
    });

    final subject = List<SubjectsEntity>.from((response['data'] as List)
        .map((element) => SubjectModel.fromMap(element, true)));
    return subject;
  }
}

class FreeSubjectsSubscriptionsParameter extends Equatable {
  final int systemId;
  final int stageId;
  final int classRoomId;
  final int termId;
  final int pathId;

  const FreeSubjectsSubscriptionsParameter({
    required this.systemId,
    required this.stageId,
    required this.classRoomId,
    required this.termId,
    this.pathId = 0,
  });

  @override
  List<Object> get props => [
        systemId,
        stageId,
        classRoomId,
        termId,
        pathId,
      ];
}
