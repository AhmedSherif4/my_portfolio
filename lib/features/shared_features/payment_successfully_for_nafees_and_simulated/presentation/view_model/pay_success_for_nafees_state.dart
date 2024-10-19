import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

class PaySuccessForNafeesState extends Equatable {
  final RequestStates addPayState;
  final String errorMessage;

  const PaySuccessForNafeesState(
      {this.addPayState = RequestStates.initial, this.errorMessage = ''});

  PaySuccessForNafeesState copyWith({
    RequestStates? addPayState,
    String? errorMessage,
  }) {
    return PaySuccessForNafeesState(
        addPayState: addPayState ?? this.addPayState,
        errorMessage: errorMessage ?? this.errorMessage,);
  }

  @override
  List<Object?> get props => [addPayState, errorMessage];
}
