import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/domain/entity/subject_subscriptions_entity.dart';

class AddAndDeleteSubjectEntity extends Equatable {
  final String message;
  final SubjectSubscriptionsEntity subjectSubscriptionsDetails;

  const AddAndDeleteSubjectEntity({
    required this.message,
    required this.subjectSubscriptionsDetails,
  });

  AddAndDeleteSubjectEntity copyWith({
     String? message,
     SubjectSubscriptionsEntity? subjectSubscriptionsDetails,

  }) {
    return AddAndDeleteSubjectEntity(
      message: message ?? this.message,
      subjectSubscriptionsDetails: subjectSubscriptionsDetails ?? this.subjectSubscriptionsDetails,
    );
  }

  @override
  List<Object?> get props => [message, subjectSubscriptionsDetails];
}