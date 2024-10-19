import 'package:equatable/equatable.dart';
import '../../../../packages_and_subscriptions/cart/domain/entity/cart_entity.dart';

class RequiredDataAfterPayment extends Equatable{
  final CartEntity cartData;
  final int totalPrice;
  final String coupon;
  final String couponDiscount;
  final String transactionId;
  final String apiKey;
  final String merchantId;
  final int? childId;
  final int? parentId;
  final bool payStatus;
  const RequiredDataAfterPayment({
    required this.cartData,
    required this.totalPrice,
    required this.coupon,
    required this.couponDiscount,
    this.transactionId = '',
    this.apiKey = '',
    this.merchantId = '',
    this.childId,
    this.parentId =0,
    this.payStatus = true,
  });


  RequiredDataAfterPayment copyWith({
    CartEntity? cartData,
    int? totalPrice,
    int? childId,
    String? coupon,
    String? couponDiscount,
    String? transactionId,
    String? apiKey,
    String? merchantId,
    bool? payStatus,
    int? parentId,
  }) => RequiredDataAfterPayment(
    cartData: cartData?? this.cartData,
    totalPrice: totalPrice?? this.totalPrice,
    coupon: coupon?? this.coupon,
    couponDiscount: couponDiscount?? this.couponDiscount,
    transactionId: transactionId?? this.transactionId,
    apiKey:  apiKey ?? this.apiKey,
    merchantId: merchantId ?? this.merchantId,
    childId: childId ?? this.childId,
    payStatus: payStatus?? this.payStatus,
    parentId: parentId ?? this.parentId,
  );

  @override
  List<Object?> get props => [
    cartData,
    totalPrice,
    coupon,
    couponDiscount,
    transactionId,
    apiKey,
    merchantId,
    childId,
    parentId,
    childId,
    payStatus,
  ];
}