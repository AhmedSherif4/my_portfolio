import 'package:equatable/equatable.dart';

class PaymentDataEntity extends Equatable {
  final bool paymentStatus;
  final String payKey;
  final String merchantId;

  const PaymentDataEntity(
      {required this.paymentStatus,
      required this.payKey,
      required this.merchantId});


  @override
  List<Object?> get props => [
        paymentStatus,
        payKey,
        merchantId,
      ];
}
