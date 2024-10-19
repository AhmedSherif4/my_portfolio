part of 'all_subscription_bloc.dart';

abstract class AllSubscriptionEvent extends Equatable {
  const AllSubscriptionEvent();
}

class GetAllSubscriptionEvent extends AllSubscriptionEvent {
  final int? childId;

  const GetAllSubscriptionEvent({required this.childId});

  @override
  List<Object?> get props => [childId];
}
