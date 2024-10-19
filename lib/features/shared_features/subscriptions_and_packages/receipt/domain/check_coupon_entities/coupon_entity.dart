
import 'package:equatable/equatable.dart';

class CouponEntity extends Equatable {
  final int id;
  final String code;
  final String discountType;
  final int discount;
  final int discountStart;
  final int currentUse;
  final int usages;
  final bool status;
  final String expiryDate;
  final int childId;
  final String createdAt;
  const CouponEntity({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discount,
    required this.discountStart,
    required this.currentUse,
    required this.usages,
    required this.status,
    required this.expiryDate,
    required this.childId,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      code,
      discountType,
      discount,
      discountStart,
      currentUse,
      usages,
      status,
      expiryDate,
      childId,
    ];
  }

  CouponEntity copyWith({
    int? id,
    String? code,
    String? discountType,
    int? discount,
    int? discountStart,
    int? currentUse,
    int? usages,
    bool? status,
    String? expiryDate,
    int? childId,
    String? createdAt,
  }) {
    return CouponEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      discountType: discountType ?? this.discountType,
      discount: discount ?? this.discount,
      discountStart: discountStart ?? this.discountStart,
      currentUse: currentUse ?? this.currentUse,
      usages: usages ?? this.usages,
      status: status ?? this.status,
      expiryDate: expiryDate ?? this.expiryDate,
      childId: childId ?? this.childId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
