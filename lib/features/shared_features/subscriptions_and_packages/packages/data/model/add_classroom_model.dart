import 'package:equatable/equatable.dart';

import '../../../../child_subscriptions/domain/entity/child_subscriptions_studying_entity.dart';

class AddClassroomModelHaveTermsAndOptionalSubjects extends Equatable{
  final String message;
  final List<ChildSubscriptionsStudyingEntity> allTerms;
  final List<ChildSubscriptionsStudyingEntity> allSubjects;

  const AddClassroomModelHaveTermsAndOptionalSubjects({
    required this.message,
    required this.allTerms,
    required this.allSubjects,
  });

  factory AddClassroomModelHaveTermsAndOptionalSubjects.fromJson(Map<String, dynamic> json){
    return AddClassroomModelHaveTermsAndOptionalSubjects(
      message: json['message'],
      allTerms: json['data']['terms'] == null ? <ChildSubscriptionsStudyingEntity>[]: List<ChildSubscriptionsStudyingEntity>.from(json['data']['terms'].map((i) => ChildSubscriptionsStudyingEntity(id: i['id'], name: i['name']))),
      allSubjects: json['data']['subjects'] == null ? <ChildSubscriptionsStudyingEntity>[] : List<ChildSubscriptionsStudyingEntity>.from(json['data']['subjects'].map((i) => ChildSubscriptionsStudyingEntity(id: i['id'], name: i['name']))),
    );
  }

  @override
  List<Object?> get props => [allTerms, allSubjects];
}

class AddTermModelHaveOptionalSubjects extends Equatable{
  final String message;
  final List<ChildSubscriptionsStudyingEntity> allSubjects;

  const AddTermModelHaveOptionalSubjects({
    required this.message,
    required this.allSubjects,
  });

  factory AddTermModelHaveOptionalSubjects.fromJson(Map<String, dynamic> json){
    return AddTermModelHaveOptionalSubjects(
      message: json['message'],
      allSubjects: json['data'] == null ? <ChildSubscriptionsStudyingEntity>[] : List<ChildSubscriptionsStudyingEntity>.from(json['data'].map((i) => ChildSubscriptionsStudyingEntity(id: i['id'], name: i['name']))),
    );
  }

  @override
  List<Object?> get props => [allSubjects, message];

}
