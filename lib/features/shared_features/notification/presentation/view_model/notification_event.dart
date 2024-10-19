part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class GetAllNotificationEvent extends NotificationEvent {
  final int pageNumber;

  const GetAllNotificationEvent({
    required this.pageNumber,
  });

  @override
  List<Object> get props => [pageNumber];
}

class ReadAllNotificationEvent extends NotificationEvent {
  @override
  List<Object?> get props => [];
}

class UpdateNotificationEvent extends NotificationEvent {
  final NotificationManagerParameters notificationManagerParameters;

  const UpdateNotificationEvent({required this.notificationManagerParameters});

  @override
  List<Object?> get props => [notificationManagerParameters];
}
