import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/features/shared_features/notification/data/remote_data_source/notification_remote_data_source.dart';
import 'package:my_portfolio/features/shared_features/notification/domain/entity/notification_entity.dart';
import 'package:my_portfolio/features/shared_features/notification/domain/repository/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  final BaseRepository baseRepository;

  NotificationRepositoryImpl(
      {required this.notificationRemoteDataSource,
      required this.baseRepository});

  @override
  Future<Either<Failure, NotificationEntity>> getNotification({
    required int pageNumber,
  }) {
    return baseRepository.checkExceptionForRemoteData(
      notificationRemoteDataSource.getNotification(pageNumber: pageNumber),
    );
  }

  @override
  Future<Either<Failure, String>> readAllNotification() {
    return baseRepository.checkExceptionForRemoteData(
      notificationRemoteDataSource.readAllNotification(),
    );
  }

  @override
  Future<Either<Failure, String>> updateNotification(
      {required NotificationManagerParameters notificationManagerParameters}) {
    return baseRepository.checkExceptionForRemoteData(
      notificationRemoteDataSource.updateNotification(
        notificationManagerParameters: notificationManagerParameters,
      ),
    );
  }
}
