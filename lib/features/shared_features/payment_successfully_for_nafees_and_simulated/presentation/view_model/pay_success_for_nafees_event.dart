
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/repository/pay_success_repo.dart';

import '../../domain/repository/pay_for_nafees_success_repo.dart';

abstract class PaySuccessForNafeesEvent extends Equatable {}

class AddPaymentToServerForNafeesEvent extends PaySuccessForNafeesEvent {
  final PaySuccessForNafeesParameters parameters;

  AddPaymentToServerForNafeesEvent({required this.parameters});
  @override
  List<Object?> get props => [parameters];
}