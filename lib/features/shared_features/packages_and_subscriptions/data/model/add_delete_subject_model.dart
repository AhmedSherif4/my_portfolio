
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/domain/entity/add_delete_subject_entity.dart';

import 'subject_subscriptions_model.dart';

class AddAndDeleteSubjectModel extends AddAndDeleteSubjectEntity {
  const AddAndDeleteSubjectModel({
    required super.message,
    required super.subjectSubscriptionsDetails,
  });

  factory AddAndDeleteSubjectModel.fromJson(Map<String, dynamic> json) {
    return AddAndDeleteSubjectModel(
      message: json['message'],
      subjectSubscriptionsDetails: SubjectSubscriptionsModel.fromJson(json['data']),
    );
  }
}



