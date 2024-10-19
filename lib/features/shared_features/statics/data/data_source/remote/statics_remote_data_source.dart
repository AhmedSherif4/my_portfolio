part of '../../../statics.dart';

abstract class BaseStaticsRemoteDataSource {
  Future<TimeInAppModel> getTimeInApp(TimeInAppInputs timeInAppInputs);

  Future<List<SubjectsEntity>> getSubjects({
    required GetStaticsParam subjectsParameters,
  });

  Future<LessonsStaticsModel> getLessonsStatics({
    required GetStaticsParam parameters,
  });

  Future<LevelStaticsModel> getLevelStatics({
    required GetStaticsParam parameters,
  });

  Future<List<BestSubjectsModel>> getLBestSubjects({
    required GetStaticsParam parameters,
  });

  Future<List<FailsSkillsForLessonsModel>> getFailsSkills({
    required GetFailsSkillsWithQuestionsParameters parameters,
  });

  Future<QuestionEntity> getFailsSkillsQuestions({required int id});

}

@LazySingleton(as: BaseStaticsRemoteDataSource)
class StaticsRemoteDataSource extends BaseStaticsRemoteDataSource {
  final BaseRemoteDataSource dataSource;

  StaticsRemoteDataSource({required this.dataSource});

  @override
  Future<TimeInAppModel> getTimeInApp(TimeInAppInputs timeInAppInputs) async {
    final response =
        getIt<UserLocalDataSource>().getUserData()!.type == UsersType.child.name
            ? await dataSource.postData(
                url: EndPoints.timeInAppPath,
                body: {
                  "start_date": timeInAppInputs.startDate.toString(),
                  "end_date": timeInAppInputs.endDate.toString(),
                },
              )
            : await dataSource.postData(
                url: getIt<UserLocalDataSource>().getUserData()!.type ==
                        UsersType.parent.name
                    ? EndPoints.parentTimeInAppPath
                    : EndPoints.institutionTimeInAppPath,
                body: {
                  "start_date": timeInAppInputs.startDate.toString(),
                  "end_date": timeInAppInputs.endDate.toString(),
                  'child_id': timeInAppInputs.childId,
                },
              );
    return TimeInAppModel.fromJson(response['data']);
  }

  @override
  Future<List<SubjectsEntity>> getSubjects({
    required GetStaticsParam subjectsParameters,
  }) async {
    final response = AppReference.userIsChild()
        ? await dataSource.postData(url: EndPoints.subjectsForStatics, body: {
            'system_id': subjectsParameters.systemId,
            'stage_id': subjectsParameters.stageId,
            'classroom_id': subjectsParameters.classRoomId,
            'term_id': subjectsParameters.termId,
            'path_id': subjectsParameters.pathId,
          })
        : await dataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentSubjectsForStatics
                : EndPoints.institutionSubjectsForStatics,
            body: {
                'system_id': subjectsParameters.systemId,
                'stage_id': subjectsParameters.stageId,
                'classroom_id': subjectsParameters.classRoomId,
                'term_id': subjectsParameters.termId,
                'path_id': subjectsParameters.pathId,
                'child_id': subjectsParameters.childId,
              });

    final subject = List<SubjectsEntity>.from((response['data'] as List)
        .map((element) => SubjectModel.fromMap(element, true))).toList();

    return subject;
  }

  @override
  Future<LessonsStaticsModel> getLessonsStatics(
      {required GetStaticsParam parameters}) async {
    final response = parameters.fromNafees
        ? await dataSource.postData(url:AppReference.userIsChild() ?  EndPoints.planLessonsStats : EndPoints.parentPlanLessonsStats, body:AppReference.userIsChild() ?  {
      'category_id': parameters.subjectId,
    }:{
      'category_id': parameters.subjectId,
      'child_id': parameters.childId,
    })
        : AppReference.userIsChild()
            ? await dataSource
                .postData(url: EndPoints.lessonsStaticsPath, body: {
                'system_id': parameters.systemId,
                'path_id': parameters.pathId,
                'stage_id': parameters.stageId,
                'classroom_id': parameters.classRoomId,
                'term_id': parameters.termId,
                'subject_id': parameters.subjectId,
              })
            : await dataSource.postData(
                url: AppReference.userIsParent()
                    ? EndPoints.parentChildLessonsStaticsPath
                    : EndPoints.institutionLessonsStaticsPath,
                body: {
                    'system_id': parameters.systemId,
                    'path_id': parameters.pathId,
                    'stage_id': parameters.stageId,
                    'classroom_id': parameters.classRoomId,
                    'term_id': parameters.termId,
                    'subject_id': parameters.subjectId,
                    'child_id': parameters.childId,
                  });

    return LessonsStaticsModel.fromJson(response['data']);
  }

  @override
  Future<List<BestSubjectsModel>> getLBestSubjects(
      {required GetStaticsParam parameters}) async {
    final response = AppReference.userIsChild()
        ? await dataSource.postData(url: EndPoints.bestSubjectsPath, body: {
            'system_id': parameters.systemId,
            'path_id': parameters.pathId==0?null:parameters.pathId,
            'stage_id': parameters.stageId,
            'classroom_id': parameters.classRoomId,
            'term_id': parameters.termId,
          })
        : await dataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentBestSubjectsPath
                : EndPoints.institutionBestSubjectsPath,
            body: {
                'system_id': parameters.systemId,
                'path_id': parameters.pathId==0?null:parameters.pathId,
                'stage_id': parameters.stageId,
                'classroom_id': parameters.classRoomId,
                'term_id': parameters.termId,
                'child_id': parameters.childId,
              });
    final bestSubject = List<BestSubjectsModel>.from((response['data'] as List)
        .map((element) => BestSubjectsModel.fromJson(element))).toList();

    return bestSubject;
  }

  @override
  Future<LevelStaticsModel> getLevelStatics(
      {required GetStaticsParam parameters}) async {
    final response = AppReference.userIsChild()
        ? await dataSource.postData(url: EndPoints.levelStaticsPath, body: {
            'system_id': parameters.systemId,
            'path_id': parameters.pathId,
            'stage_id': parameters.stageId,
            'classroom_id': parameters.classRoomId,
            'term_id': parameters.termId,
            'subject_id': parameters.subjectId,
            'level_id': parameters.levelId,
          })
        : await dataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentLevelStaticsPath
                : EndPoints.institutionLevelStaticsPath,
            body: {
                'system_id': parameters.systemId,
                'path_id': parameters.pathId,
                'stage_id': parameters.stageId,
                'classroom_id': parameters.classRoomId,
                'term_id': parameters.termId,
                'subject_id': parameters.subjectId,
                'level_id': parameters.levelId,
                'child_id': parameters.childId,
              });

    return LevelStaticsModel.fromJson(response['data']);
  }


  @override
  Future<List<FailsSkillsForLessonsModel>> getFailsSkills(
      {required GetFailsSkillsWithQuestionsParameters parameters}) async {
    final response = AppReference.userIsChild()
        ? await dataSource
            .postData(url: EndPoints.failsSkillsForLessonsPath, body: {
            'subject_id': parameters.subjectId,

    })
        : await dataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentFailsSkillsForLessonsPath
                : EndPoints.institutionFailsSkillsForLessonsPath,
            body: {
                'subject_id': parameters.subjectId,
                'child_id': parameters.childId,

            });
    if (response['data'] != null) {
      final failsSkills = List<FailsSkillsForLessonsModel>.from(
              (response['data'] as List).map(
                  (element) => FailsSkillsForLessonsModel.fromJson(element)))
          .toList();
      return failsSkills;
    } else {
      return [];
    }
  }

  @override
  Future<QuestionEntity> getFailsSkillsQuestions({required int id}) async{
    final response =  await dataSource
            .postData(url: EndPoints.failsSkillsQuestionPath, body: {
            'id': id,
          });
    // response.log();
    return QuestionModel.fromMap(response['data']);
  }
}
