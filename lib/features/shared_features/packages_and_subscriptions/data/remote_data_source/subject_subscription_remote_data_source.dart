import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../domain/entity/add_delete_subject_entity.dart';
import '../../domain/entity/subject_subscriptions_entity.dart';
import '../model/add_delete_subject_model.dart';
import '../model/subject_subscriptions_model.dart';

abstract class SubjectSubscriptionRemoteDataSource {
  Future<AddAndDeleteSubjectEntity> deleteSubjectData(
      {required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs});
  Future<AddAndDeleteSubjectEntity> addSubjectData(
      {required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs});
  Future<String> addOptionalSubjectData(
      {required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs});
  Future<SubjectSubscriptionsEntity> getSubjectSubscriptions(
      SubjectSubscriptionsInputs subjectSubscriptionsInputs);
}

@LazySingleton(as: SubjectSubscriptionRemoteDataSource)
class SubjectSubscriptionRemoteDataSourceImpl
    implements SubjectSubscriptionRemoteDataSource {
  final BaseRemoteDataSource _dataSource;

  SubjectSubscriptionRemoteDataSourceImpl(this._dataSource);

  @override
  Future<AddAndDeleteSubjectEntity> addSubjectData(
      {required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs}) async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()
            ? EndPoints.addSubjectPath
            : EndPoints.parentAddSubjectPath,
        body: AppReference.userIsChild()
            ? {
                'subject_id': addAndDeleteSubjectInputs.subjectId,
                "path_id": addAndDeleteSubjectInputs.pathId == 0
                    ? null
                    : addAndDeleteSubjectInputs.pathId,
              }
            : {
                'subject_id': addAndDeleteSubjectInputs.subjectId,
                'child_id': addAndDeleteSubjectInputs.childId,
                "path_id": addAndDeleteSubjectInputs.pathId == 0
                    ? null
                    : addAndDeleteSubjectInputs.pathId,
              });

    return AddAndDeleteSubjectModel.fromJson(response);
  }

  @override
  Future<String> addOptionalSubjectData(
      {required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs}) async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()
            ? EndPoints.addOptionalSubjectPath
            : EndPoints.parentAddOptionalSubjectPath,
        body: AppReference.userIsChild()
            ? {
                'subject_id': addAndDeleteSubjectInputs.subjectId,
                'term_id': addAndDeleteSubjectInputs.termId,
                "path_id": addAndDeleteSubjectInputs.pathId == 0
                    ? null
                    : addAndDeleteSubjectInputs.pathId,
              }
            : {
                'subject_id': addAndDeleteSubjectInputs.subjectId,
                'term_id': addAndDeleteSubjectInputs.termId,
                "path_id": addAndDeleteSubjectInputs.pathId == 0
                    ? null
                    : addAndDeleteSubjectInputs.pathId,
                'child_id': addAndDeleteSubjectInputs.childId,
              });
    return response['message'];
  }

  @override
  Future<AddAndDeleteSubjectEntity> deleteSubjectData(
      {required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs}) async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()
            ? EndPoints.deleteSubjectPath
            : EndPoints.parentDeleteSubjectPath,
        body: AppReference.userIsChild()
            ? {
                'subject_id': addAndDeleteSubjectInputs.subjectId,
                "path_id": addAndDeleteSubjectInputs.pathId == 0
                    ? null
                    : addAndDeleteSubjectInputs.pathId,
              }
            : {
                'subject_id': addAndDeleteSubjectInputs.subjectId,
                'child_id': addAndDeleteSubjectInputs.childId,
                "path_id": addAndDeleteSubjectInputs.pathId == 0
                    ? null
                    : addAndDeleteSubjectInputs.pathId,
              });

    return AddAndDeleteSubjectModel.fromJson(response);
  }

  @override
  Future<SubjectSubscriptionsEntity> getSubjectSubscriptions(
      SubjectSubscriptionsInputs subjectSubscriptionsInputs) async {
    // 'subjects here'.log();
    // subjectSubscriptionsInputs.childId.log();
    // subjectSubscriptionsInputs.pathId.log();
    // subjectSubscriptionsInputs.classRoomId.log();
    // subjectSubscriptionsInputs.termId.log();

    final response = await _dataSource.postData(
        url: AppReference.userIsChild()
            ? EndPoints.getCartClassroomPath
            : EndPoints.parentGetCartClassroomPath,
        body: AppReference.userIsChild()
            ? {
                "classroom_id":
                    subjectSubscriptionsInputs.classRoomId.toString(),
                "path_id": subjectSubscriptionsInputs.pathId == 0
                    ? null
                    : subjectSubscriptionsInputs.pathId,
              }
            : {
                "classroom_id":
                    subjectSubscriptionsInputs.classRoomId.toString(),
                "child_id": subjectSubscriptionsInputs.childId.toString(),
                "path_id": subjectSubscriptionsInputs.pathId == 0
                    ? null
                    : subjectSubscriptionsInputs.pathId,
              });

    return SubjectSubscriptionsModel.fromJson(response['data']);
  }
}
