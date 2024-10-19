import 'package:injectable/injectable.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../my_app/app_reference.dart';
import '../../../../child_flow/home/data/home_models/subject_model.dart';
import '../../../../child_flow/home/domain/home_entities/subjects_entity.dart';
import '../../../../child_flow/questions/shared/data/go_to_question_parameter.dart';
import '../../domain/child_subscriptions_base_repository/child_subscriptions_base_repository.dart';
import '../../domain/entity/child_subscriptions_studying_entity.dart';
import '../models/child_subscriptions_studying_model.dart';

abstract class ChildSubscriptionsRemoteDataSource {
  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsSystems(
      {int? childID});

  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsStages(
      {required GetChildSubscriptionsTermsOrPathsParameters
          systemIdAndChildData});

  Future<List<ChildSubscriptionsStudyingEntity>>
      getChildSubscriptionsClassRoom({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  });

  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsTerms({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  });

  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsPaths({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  });

  Future<List<SubjectsEntity>> getChildSubscriptionsSubjects({
    required ParameterGoToQuestions subjectsParameters,
  });
}

@LazySingleton(as: ChildSubscriptionsRemoteDataSource)
class GradeChoosingRemoteDataSourceImpl
    implements ChildSubscriptionsRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  GradeChoosingRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsClassRoom(
      {required GetChildSubscriptionsTermsOrPathsParameters parameters}) async {
    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource.postData(
            url: EndPoints.childSubscriptionsClassroomsPath,
            body: {
              'system_id': parameters.systemId,
              'stage_id': parameters.stageId,
            },
          )
        : await baseRemoteDataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentChildSubscriptionsClassroomsPath
                : EndPoints.institutionChildSubscriptionsClassroomsPath,
            body: {
              'system_id': parameters.systemId,
              'stage_id': parameters.stageId,
              'child_id': parameters.childData!.userId,
            },
          );
    return List<ChildSubscriptionsStudyingEntity>.from(
        (response['data'] as List).map((element) =>
            ChildSubscriptionsStudyingModel.fromJson(
                element, SubscriptionsType.classRoom)));
  }

  @override
  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsTerms({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  }) async {
    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource
            .postData(url: EndPoints.childSubscriptionsTermsPath, body: {
            'system_id': parameters.systemId,
            'stage_id': parameters.stageId,
            'classroom_id': parameters.classRoomId,
          })
        : await baseRemoteDataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentChildSubscriptionsTermsPath
                : EndPoints.institutionChildSubscriptionsTermsPath,
            body: {
                'system_id': parameters.systemId,
                'stage_id': parameters.stageId,
                'classroom_id': parameters.classRoomId,
                'child_id': parameters.childData!.userId,
              });
    return List<ChildSubscriptionsStudyingEntity>.from(
        (response['data'] as List).map((element) =>
            ChildSubscriptionsStudyingModel.fromJson(
                element, SubscriptionsType.terms)));
  }

  @override
  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsPaths({
    required GetChildSubscriptionsTermsOrPathsParameters parameters,
  }) async {
    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource
            .postData(url: EndPoints.childSubscriptionsPathsPath, body: {
            'system_id': parameters.systemId,
            'stage_id': parameters.stageId,
            'classroom_id': parameters.classRoomId,
            'term_id': parameters.termId,
          })
        : await baseRemoteDataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentChildSubscriptionsPathsPath
                : EndPoints.institutionChildSubscriptionsPathsPath,
            body: {
                'system_id': parameters.systemId,
                'stage_id': parameters.stageId,
                'classroom_id': parameters.classRoomId,
                'child_id': parameters.childData!.userId,
                'term_id': parameters.termId,
              });

    return List<ChildSubscriptionsStudyingEntity>.from(
        (response['data'] as List).map((element) =>
            ChildSubscriptionsStudyingModel.fromJson(
                element, SubscriptionsType.paths)));
  }

  @override
  Future<List<SubjectsEntity>> getChildSubscriptionsSubjects(
      {required ParameterGoToQuestions subjectsParameters}) async {
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

  @override
  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsStages(
      {required GetChildSubscriptionsTermsOrPathsParameters
          systemIdAndChildData}) async {
    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource.postData(
            url: EndPoints.childSubscriptionsStagesPath,
            body: {
              'system_id': systemIdAndChildData.systemId,
            },
          )
        : await baseRemoteDataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentChildSubscriptionsStagesPath
                : EndPoints.institutionChildSubscriptionsStagesPath,
            body: {
              'system_id': systemIdAndChildData.systemId,
              'child_id': systemIdAndChildData.childData!.userId,
            },
          );
    return List<ChildSubscriptionsStudyingEntity>.from(
      (response['data'] as List).map(
        (element) => ChildSubscriptionsStudyingModel.fromJson(
            element, SubscriptionsType.stages),
      ),
    );
  }

  @override
  Future<List<ChildSubscriptionsStudyingEntity>> getChildSubscriptionsSystems(
      {int? childID}) async {
    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource.postData(
            url: EndPoints.childSubscriptionsSystemPath,
            body: {},
          )
        : await baseRemoteDataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentChildSubscriptionsSystemPath
                : EndPoints.institutionChildSubscriptionsSystemPath,
            body: {
              'child_id': childID,
            },
          );

    return List<ChildSubscriptionsStudyingEntity>.from(
      (response['data'] as List).map(
        (element) => ChildSubscriptionsStudyingModel.fromJson(
            element, SubscriptionsType.system),
      ),
    );
  }
}
