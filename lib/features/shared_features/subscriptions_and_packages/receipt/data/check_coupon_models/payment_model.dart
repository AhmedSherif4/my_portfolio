import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_entities/payment_data_entity.dart';

class PaymentDataModel extends PaymentDataEntity {
  const PaymentDataModel({
    required super.paymentStatus,
    required super.payKey,
    required super.merchantId,
  });

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentDataModel(
      paymentStatus: json['payment_status'],
      payKey: json['moyasar_ApiKey'] ?? '',
      merchantId: json['moyasar_merchantId']??'',
    );
  }
}
