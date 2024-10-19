
import '../../domain/check_coupon_entities/coupon_entity.dart';

class CouponModel extends CouponEntity {
  const CouponModel({
    required super.id,
    required super.code,
    required super.discountType,
    required super.discount,
    required super.discountStart,
    required super.currentUse,
    required super.usages,
    required super.status,
    required super.expiryDate,
    required super.childId,
    required super.createdAt,
  });

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id'] as int,
      code: map['code'] as String,
      discountType: map['discount_type'] as String,
      discount: map['discount'] as int,
      discountStart: map['discount_start'] as int,
      currentUse: map['current_use'] as int,
      usages: map['usages'] as int,
      status: map['status'] as bool,
      expiryDate: map['expiry_date'] as String,
      createdAt: map['created_at'] as String,
      childId: map['child_id'] ?? 0,
    );
  }
}
