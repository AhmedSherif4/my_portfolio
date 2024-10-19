import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import 'package:my_portfolio/features/shared_features/notification/domain/entity/notification_entity.dart';

import '../../../../../core/failure/failure.dart';
import '../repository/notification_repository.dart';

@LazySingleton()
class NotificationUseCase extends BaseUseCase<NotificationEntity, int> {
  final NotificationRepository repository;

  NotificationUseCase({required this.repository});

  @override
  Future<Either<Failure, NotificationEntity>> call(int parameter) async {
    return await repository.getNotification(pageNumber: parameter);
  }
}

@LazySingleton()
class ReadAllNotificationUseCase extends BaseUseCase<String, NoParameter> {
  final NotificationRepository repository;

  ReadAllNotificationUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(NoParameter parameter) async {
    return await repository.readAllNotification();
  }
}

@LazySingleton()
class UpdateNotificationUseCase
    extends BaseUseCase<String, NotificationManagerParameters> {
  final NotificationRepository repository;

  UpdateNotificationUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      NotificationManagerParameters parameter) async {
    return await repository.updateNotification(
        notificationManagerParameters: parameter);
  }
}
