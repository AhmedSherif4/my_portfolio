import 'package:equatable/equatable.dart';

import '../../../rank/rank.dart';


class NotificationEntity extends Equatable {
  final int unReadNotificationCount;
  final List<NotificationItemEntity> notifications;
  final PaginationModel paginationEntity;

  const NotificationEntity({
    required this.paginationEntity,
    required this.notifications,
    required this.unReadNotificationCount,
  });

  @override
  List<Object> get props => [
        unReadNotificationCount,
        notifications,
      ];
}

class NotificationItemEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  final String imgPath;
  final int isRead;

  const NotificationItemEntity(
      {required this.title,
      required this.body,
      required this.imgPath,
      required this.isRead,
      required this.id});

  @override
  List<Object> get props => [title, body, imgPath, id, isRead];
}
