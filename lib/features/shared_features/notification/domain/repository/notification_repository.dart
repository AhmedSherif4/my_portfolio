import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/shared_features/notification/domain/entity/notification_entity.dart';

import '../../../../../core/failure/failure.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationEntity>> getNotification(
      {required int pageNumber});

  Future<Either<Failure, String>> readAllNotification();

  Future<Either<Failure, String>> updateNotification({
    required NotificationManagerParameters notificationManagerParameters,
  });
}

class NotificationManagerParameters extends Equatable {
  final String markExam;
  final String reUploadExam;
  final String lessonFinish;
  final String login;
  final String sessionTime;

  const NotificationManagerParameters({
    required this.markExam,
    required this.reUploadExam,
    required this.lessonFinish,
    required this.login,
    required this.sessionTime,
  });

  NotificationManagerParameters copyWith({
    String? markExam,
    String? reUploadExam,
    String? lessonFinish,
    String? login,
    String? sessionTime,
  }) {
    return NotificationManagerParameters(
      markExam: markExam ?? this.markExam,
      reUploadExam: reUploadExam ?? this.reUploadExam,
      lessonFinish: lessonFinish ?? this.lessonFinish,
      login: login ?? this.login,
      sessionTime: sessionTime ?? this.sessionTime,
    );
  }

  @override
  List<Object?> get props => [
        markExam,
        reUploadExam,
        lessonFinish,
        login,
        sessionTime,
      ];
}
