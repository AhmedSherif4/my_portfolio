import 'package:equatable/equatable.dart';
import '../../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../../child_flow/questions/shared/data/go_to_question_parameter.dart';
import '../../../domain/child_subscriptions_base_repository/child_subscriptions_base_repository.dart';
import '../../../domain/entity/child_subscriptions_studying_entity.dart';



abstract class SubscriptionSystemsEvent extends Equatable {
  const SubscriptionSystemsEvent();

  @override
  List<Object?> get props => [];
}

class GetSystemsEvent extends SubscriptionSystemsEvent {
  final int? childId;
  final UserEntity? userEntity;
  const GetSystemsEvent({this.userEntity, this.childId});

  @override
  List<Object?> get props => [childId];
}

class GetStageEvent extends SubscriptionSystemsEvent {

  final GetChildSubscriptionsTermsOrPathsParameters systemIdAndChildData;

  const GetStageEvent({required this.systemIdAndChildData});

  @override
  List<Object> get props => [systemIdAndChildData];
}

class GetClassRoomEvent extends SubscriptionSystemsEvent {
  final GetChildSubscriptionsTermsOrPathsParameters getClassRoomParameters;
  const GetClassRoomEvent({required this.getClassRoomParameters});

  @override
  List<Object> get props => [getClassRoomParameters];
}

class GetSubTermsEvent extends SubscriptionSystemsEvent {
  final GetChildSubscriptionsTermsOrPathsParameters parameters;

  const GetSubTermsEvent(this.parameters);

  @override
  List<Object> get props => [parameters];
}

class GetSubPathEvent extends SubscriptionSystemsEvent {
  final GetChildSubscriptionsTermsOrPathsParameters parameters;

  const GetSubPathEvent(this.parameters);

  @override
  List<Object> get props => [parameters];
}
class GetSubscriptionsSubjectsEvent extends SubscriptionSystemsEvent {
  final ParameterGoToQuestions parameter;

  const GetSubscriptionsSubjectsEvent({required this.parameter});

  @override
  List<Object> get props => [parameter];
}

class ChangeSystemEvent extends SubscriptionSystemsEvent {
  final ChildSubscriptionsStudyingEntity currentSystem;
  const ChangeSystemEvent(this.currentSystem);

  @override
  List<Object> get props => [currentSystem];
}

class ChangeStagesEvent extends SubscriptionSystemsEvent {
  final ChildSubscriptionsStudyingEntity currentStage;

  const ChangeStagesEvent(this.currentStage);

  @override
  List<Object> get props => [currentStage];
}

class ChangeClassRoomEvent extends SubscriptionSystemsEvent {
  final ChildSubscriptionsStudyingEntity currentClassRoom;

  const ChangeClassRoomEvent(this.currentClassRoom);

  @override
  List<Object> get props => [currentClassRoom];
}

class ChangeTermEvent extends SubscriptionSystemsEvent {
  final ChildSubscriptionsStudyingEntity currentTerm;

  const ChangeTermEvent(this.currentTerm);

  @override
  List<Object> get props => [currentTerm];
}

class ChangePathEvent extends SubscriptionSystemsEvent {
  final ChildSubscriptionsStudyingEntity currentPath;

  const ChangePathEvent(this.currentPath);

  @override
  List<Object> get props => [currentPath];
}

class ChangeSubjectEvent extends SubscriptionSystemsEvent {
  final ChildSubscriptionsStudyingEntity currentPath;

  const ChangeSubjectEvent(this.currentPath);

  @override
  List<Object> get props => [currentPath];
}
