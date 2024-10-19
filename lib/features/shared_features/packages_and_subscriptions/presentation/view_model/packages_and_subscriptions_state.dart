import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/presentation/view_model/packages_and_subscriptions_bloc.dart';

import '../../domain/entity/subject_subscriptions_entity.dart';

class PackagesAndSubscriptionsState extends Equatable {

  final SelectAllState addAllSubjects;

  final RequestStates addSubjectToCartState;
  final String addSubjectToCartMessage;

  final RequestStates addOptionalSubjectToCartState;
  final String addOptionalSubjectToCartMessage;

  final RequestStates deleteSubjectFromCartState;
  final String deleteSubjectFromCartMessage;

  final RequestStates subjectSubscriptionsState;
  final SubjectSubscriptionsEntity subjectSubscriptions;
  final String subjectSubscriptionsEventMessage;

  final int currentTermId;


  const PackagesAndSubscriptionsState({
   this.addSubjectToCartState = RequestStates.initial,
   this.addSubjectToCartMessage = '',
   this.addOptionalSubjectToCartState = RequestStates.initial,
   this.addOptionalSubjectToCartMessage = '',
   this.deleteSubjectFromCartState = RequestStates.initial,
   this.deleteSubjectFromCartMessage = '',
   this.subjectSubscriptionsState = RequestStates.initial,
   this.subjectSubscriptions = const SubjectSubscriptionsEntity(terms: [], optionalSubject: []),
   this.subjectSubscriptionsEventMessage = '',
   this.currentTermId = 0,
    this.addAllSubjects = SelectAllState.init,
  });

  PackagesAndSubscriptionsState copyWith({
    RequestStates? addSubjectToCartState,
    String? addSubjectToCartMessage,
    RequestStates? addOptionalSubjectToCartState,
    String? addOptionalSubjectToCartMessage,
    RequestStates? deleteSubjectFromCartState,
    String? deleteSubjectFromCartMessage,
    RequestStates? subjectSubscriptionsState,
    SubjectSubscriptionsEntity? subjectSubscriptions,
    String? subjectSubscriptionsEventMessage,
    int? currentTermId,
    SelectAllState? addAllSubjects,
  }) {
    return PackagesAndSubscriptionsState(
     addSubjectToCartState: addSubjectToCartState ?? this.addSubjectToCartState,
     addSubjectToCartMessage: addSubjectToCartMessage ?? this.addSubjectToCartMessage,
     addOptionalSubjectToCartState: addOptionalSubjectToCartState ?? this.addOptionalSubjectToCartState,
     addOptionalSubjectToCartMessage: addOptionalSubjectToCartMessage ?? this.addOptionalSubjectToCartMessage,
     deleteSubjectFromCartState: deleteSubjectFromCartState ?? this.deleteSubjectFromCartState,
     deleteSubjectFromCartMessage: deleteSubjectFromCartMessage ?? this.deleteSubjectFromCartMessage,
     subjectSubscriptionsState: subjectSubscriptionsState ?? this.subjectSubscriptionsState,
     subjectSubscriptions: subjectSubscriptions ?? this.subjectSubscriptions,
     currentTermId: currentTermId ?? this.currentTermId,
     subjectSubscriptionsEventMessage: subjectSubscriptionsEventMessage ?? this.subjectSubscriptionsEventMessage,
     addAllSubjects: addAllSubjects ?? this.addAllSubjects,
    );
  }

  @override
  List<Object?> get props => [
        addSubjectToCartState,
        addSubjectToCartMessage,
        addOptionalSubjectToCartState,
        addOptionalSubjectToCartMessage,
        deleteSubjectFromCartState,
        deleteSubjectFromCartMessage,
        subjectSubscriptionsState,
        subjectSubscriptions,
        subjectSubscriptionsEventMessage,
    currentTermId,
    addAllSubjects,
      ];
}
