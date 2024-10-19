import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

class PaySuccessState extends Equatable {
  final RequestStates addPayState;
  final String errorMessage;

  const PaySuccessState(
      {this.addPayState = RequestStates.initial, this.errorMessage = ''});

  PaySuccessState copyWith({
    RequestStates? addPayState,
    String? errorMessage,
  }) {
    return PaySuccessState(
        addPayState: addPayState ?? this.addPayState,
        errorMessage: errorMessage ?? this.errorMessage,);
  }

  @override
  List<Object?> get props => [addPayState, errorMessage];
}
