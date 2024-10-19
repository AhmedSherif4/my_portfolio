import 'package:equatable/equatable.dart';

class RequiredDataAfterNafeesPayment extends Equatable{
  final int totalPrice;
  final bool isNafees;
  final int? childId;
  final int? nafeesId;
  final int? simulatedId;
  final bool payStatus;
  const RequiredDataAfterNafeesPayment({
    required this.totalPrice,
    required this.isNafees,
    this.childId,
    this.nafeesId,
    this.simulatedId,
    this.payStatus = true,
  });


  RequiredDataAfterNafeesPayment copyWith({
    int? totalPrice,
    int? childId,
    int? nafeesId,
    int? simulatedId,
    bool? isNafees,
    bool? payStatus,
  }) => RequiredDataAfterNafeesPayment(
    totalPrice: totalPrice?? this.totalPrice,
    childId: childId ?? this.childId,
    isNafees: isNafees ?? this.isNafees,
    nafeesId: nafeesId ?? this.nafeesId,
    simulatedId: simulatedId ?? this.simulatedId,
    payStatus: payStatus?? this.payStatus,
  );

  @override
  List<Object?> get props => [
    totalPrice,
    childId,
    payStatus,
    simulatedId,
    isNafees,
    nafeesId
  ];
}