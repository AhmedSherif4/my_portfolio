part of '../../../subjects_shared_features.dart';



abstract class SubjectsSharedFeaturesRemoteDataSource {
  Future<List<SubjectsEntity>> getSharedSubjects(
      {required ParameterGoToQuestions subjectsParameters,required SubjectType subjectType});
}

@LazySingleton(as: SubjectsSharedFeaturesRemoteDataSource)
class SubjectsSharedFeaturesRemoteDataSourceImpl implements SubjectsSharedFeaturesRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  const SubjectsSharedFeaturesRemoteDataSourceImpl({
    required this.baseRemoteDataSource,
  });

  @override
  Future<List<SubjectsEntity>> getSharedSubjects({
    required ParameterGoToQuestions subjectsParameters,
    required SubjectType subjectType
  }) async {
    if(subjectType == SubjectType.public) {
      final response = await baseRemoteDataSource.postData(
          url: EndPoints.subjects,
          body: {
            'term_id': subjectsParameters.termId,
            'path_id': subjectsParameters.pathId != 0 ? subjectsParameters.pathId : null,
          });

      final requiredSubjects = List<SubjectsEntity>.from((response['data']['required'] as List)
          .map((element) => SubjectModel.fromMap(element, true))).toList();

      final optionalSubjects =  List<SubjectsEntity>.from((response['data']['optional'] as List)
          .map((element) => SubjectModel.fromMap(element, true))).toList();

      if(response['data']['optional'].isEmpty) {
       return requiredSubjects;
      }else{
        return requiredSubjects + optionalSubjects;
      }
    }else{
      final response = AppReference.userIsChild()
          ? await baseRemoteDataSource
          .postData(url: EndPoints.childSubscriptionsSubjectsPath, body: {
        'system_id': subjectsParameters.systemId,
        'path_id': subjectsParameters.pathId != 0
            ? subjectsParameters.pathId
            : null,
        'stage_id': subjectsParameters.stageId,
        'classroom_id': subjectsParameters.classRoomId,
        'term_id': subjectsParameters.termId,
      })
          : await baseRemoteDataSource.postData(
          url: AppReference.userIsParent()
              ? EndPoints.parentChildSubscriptionsSubjectsPath
              : EndPoints.institutionChildSubscriptionsSubjectsPath,
          body: {
            'system_id': subjectsParameters.systemId,
            'path_id': subjectsParameters.pathId != 0
                ? subjectsParameters.pathId
                : null,
            'stage_id': subjectsParameters.stageId,
            'classroom_id': subjectsParameters.classRoomId,
            'term_id': subjectsParameters.termId,
            'child_id': subjectsParameters.userId,
          });

      if (response['data'] != null) {
        final subject = List<SubjectsEntity>.from(
          (response['data'] as List).map(
                (element) => SubjectModel.fromMap(
              //ToDo: change this
              element,  false,
            ),
          ),
        ).toList();

        return subject;
      } else {
        return [];
      }
    }
  }
}