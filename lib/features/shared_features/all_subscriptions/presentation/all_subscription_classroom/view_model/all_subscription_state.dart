part of 'all_subscription_bloc.dart';

class AllSubscriptionState extends Equatable {
  final RequestStates getAllSubscriptionState;
  final List<AllSubscriptionModel> allSubscription;
  final String getAllSubscriptionErrorMessage;

  const AllSubscriptionState({
    this.getAllSubscriptionState = RequestStates.initial,
    this.allSubscription = const [],
    this.getAllSubscriptionErrorMessage = '',
  });

  AllSubscriptionState copyWith({
    RequestStates? getAllSubscriptionState,
    List<AllSubscriptionModel>? allSubscription,
    String? getAllSubscriptionErrorMessage,
  }) {
    return AllSubscriptionState(
      allSubscription: allSubscription ?? this.allSubscription,
      getAllSubscriptionState:
          getAllSubscriptionState ?? this.getAllSubscriptionState,
      getAllSubscriptionErrorMessage:
          getAllSubscriptionErrorMessage ?? this.getAllSubscriptionErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        allSubscription,
        getAllSubscriptionErrorMessage,
        getAllSubscriptionState,
      ];
}
