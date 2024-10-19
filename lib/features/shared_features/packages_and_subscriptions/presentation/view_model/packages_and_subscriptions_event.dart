import 'package:equatable/equatable.dart';
import '../../domain/entity/subject_subscriptions_entity.dart';


abstract class PackagesAndSubscriptionsEvent extends Equatable {}

class AddSubjectToCartEvent extends PackagesAndSubscriptionsEvent {
  final AddAndDeleteSubjectInputs addAndDeleteSubjectInputs;
  AddSubjectToCartEvent({required this.addAndDeleteSubjectInputs});
  @override
  List<Object> get props => [addAndDeleteSubjectInputs];
}

class AddOptionalSubjectToCartEvent extends PackagesAndSubscriptionsEvent {
  final AddAndDeleteSubjectInputs addAndDeleteSubjectInputs;
  AddOptionalSubjectToCartEvent({required this.addAndDeleteSubjectInputs});
  @override
  List<Object> get props => [addAndDeleteSubjectInputs];
}

class DeleteSubjectFromCartEvent extends PackagesAndSubscriptionsEvent {
  final AddAndDeleteSubjectInputs addAndDeleteSubjectInputs;
  DeleteSubjectFromCartEvent({required this.addAndDeleteSubjectInputs});
  @override
  List<Object> get props => [addAndDeleteSubjectInputs];
}

class GetSubjectSubscriptionsDataEvent extends PackagesAndSubscriptionsEvent {
  final SubjectSubscriptionsInputs subjectSubscriptionsInputs;
  GetSubjectSubscriptionsDataEvent(
      this.subjectSubscriptionsInputs);

  @override
  List<Object> get props => [subjectSubscriptionsInputs];
}

class AddAdllSubjectsEvent extends PackagesAndSubscriptionsEvent {
  final int termIndex;
  final int childId;

  AddAdllSubjectsEvent({required this.termIndex, required this.childId});
  @override
  List<Object> get props => [termIndex, childId];
}