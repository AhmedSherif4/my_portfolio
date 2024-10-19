import 'package:my_portfolio/features/shared_features/notification/domain/entity/notification_entity.dart';

import '../../../rank/rank.dart';


class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.unReadNotificationCount,
    required super.notifications,
    required super.paginationEntity,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      unReadNotificationCount: json['unread'] ?? 0,
      notifications: (json['notifications'] as List)
          .map((e) => NotificationItemModel.fromJson(e))
          .toList(),
      paginationEntity: PaginationModel.fromJson(json['pagination']),
    );
  }
}

class NotificationItemModel extends NotificationItemEntity {
  const NotificationItemModel({
    required super.title,
    required super.body,
    required super.imgPath,
    required super.id,
    required super.isRead,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['id'],
      title: json['title'],
      body: json['content'] ?? '',
      imgPath: json['img'] ?? '',
      isRead: json['read'] ?? '',
    );
  }
}
