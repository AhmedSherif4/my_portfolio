import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart';
import 'package:my_portfolio/core/api/api_consumer.dart';
import 'package:my_portfolio/features/shared_features/notification/data/model/notification_model.dart';
import 'package:my_portfolio/features/shared_features/notification/domain/entity/notification_entity.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../my_app/app_reference.dart';
import '../../../rank/rank.dart';
import '../../domain/repository/notification_repository.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationEntity> getNotification({required int pageNumber});

  Future<String> readAllNotification();

  Future<String> updateNotification(
      {required NotificationManagerParameters notificationManagerParameters});
}

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  final BaseRemoteDataSource remoteDataSource;
  final ApiConsumer apiConsumer;

  NotificationRemoteDataSourceImpl(
      {required this.remoteDataSource, required this.apiConsumer});

  @override
  Future<NotificationEntity> getNotification({required int pageNumber}) async {
    final response = await remoteDataSource.postData(
      url:
          '${AppReference.userIsChild() ? EndPoints.childNotification : AppReference.userIsParent() ? EndPoints.parentNotification : EndPoints.institutionNotification}?page=$pageNumber',
      body: {},
    );
    if (response['data'] == null) {
      return NotificationEntity(
          paginationEntity: PaginationModel.fromJson(response['pagination']),
          notifications: const [],
          unReadNotificationCount: 0);
    } else {
      return NotificationModel.fromJson(response['data']);
    }
  }

  @override
  Future<String> readAllNotification() async {
    final response = await remoteDataSource.postData(
      url: AppReference.userIsChild()
          ? EndPoints.childReadAllNotification
          : AppReference.userIsParent()
              ? EndPoints.parentReadAllNotification
              : EndPoints.institutionReadAllNotification,
      body: {},
    );
    return response['message'] ?? '';
  }

  @override
  Future<String> updateNotification(
      {required NotificationManagerParameters
          notificationManagerParameters}) async {
    final response = await remoteDataSource.postData(
        url: AppReference.userIsParent()
            ? EndPoints.parentUpdateNotification
            : EndPoints.institutionUpdateNotification,
        body: {
          'noti_mark_exam': notificationManagerParameters.markExam,
          'noti_reupload_exam': notificationManagerParameters.reUploadExam,
          'noti_lesson_finish': notificationManagerParameters.lessonFinish,
          'noti_login': notificationManagerParameters.login,
          'noti_session_time': notificationManagerParameters.sessionTime,
        });

    return response['message'] ?? '';
  }
}
