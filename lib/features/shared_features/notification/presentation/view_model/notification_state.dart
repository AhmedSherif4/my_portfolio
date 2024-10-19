part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final List<NotificationItemEntity> allNotifications;
  final PaginationEntity? paginationModel;
  final bool isLastPage;
  final RequestStates notificationStates;
  final String notificationMessage;
  final int unNotificationCount;

  final RequestStates updateNotificationState;
  final String updateNotificationMessage;

  const NotificationState({
    this.notificationStates = RequestStates.initial,
    this.notificationMessage = '',
    this.allNotifications = const [],
    this.paginationModel,
    this.isLastPage = false,
    this.unNotificationCount = 0,
    this.updateNotificationState = RequestStates.initial,
    this.updateNotificationMessage = '',
  });

  NotificationState copyWith({
    List<NotificationItemEntity>? allNotifications,
    PaginationEntity? paginationModel,
    bool? isLastPage,
    RequestStates? notificationStates,
    String? notificationMessage,
    int? unNotificationCount,
    RequestStates? updateNotificationState,
    String? updateNotificationMessage,
  }) {
    return NotificationState(
      allNotifications: allNotifications ?? this.allNotifications,
      paginationModel: paginationModel ?? this.paginationModel,
      isLastPage: isLastPage ?? this.isLastPage,
      notificationStates: notificationStates ?? this.notificationStates,
      notificationMessage: notificationMessage ?? this.notificationMessage,
      unNotificationCount: unNotificationCount ?? this.unNotificationCount,
      updateNotificationState:
          updateNotificationState ?? this.updateNotificationState,
      updateNotificationMessage:
          updateNotificationMessage ?? this.updateNotificationMessage,
    );
  }

  @override
  List<Object?> get props => [
        allNotifications,
        paginationModel,
        isLastPage,
        notificationStates,
        notificationMessage,
        unNotificationCount,
        updateNotificationState,
        updateNotificationMessage,
      ];
}
