import 'package:equatable/equatable.dart';

import '../../../../child_flow/questions/shared/data/go_to_question_parameter.dart';

abstract class SubscriptionsAndPackagesSubjectsEvent extends Equatable {}

class GetSubscriptionsAndPackagesSubjectsEvent extends SubscriptionsAndPackagesSubjectsEvent {
  final ParameterGoToQuestions subjectsParameters;

   GetSubscriptionsAndPackagesSubjectsEvent(this.subjectsParameters);

  @override
  List<Object> get props => [subjectsParameters];
}