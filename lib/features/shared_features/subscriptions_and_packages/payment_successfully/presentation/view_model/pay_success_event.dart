
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/repository/pay_success_repo.dart';

abstract class PaySuccessEvent extends Equatable {}

class AddPaymentToServerEvent extends PaySuccessEvent {
  final PaySuccessParameters parameters;

  AddPaymentToServerEvent({required this.parameters});
  @override
  List<Object?> get props => [parameters];
}