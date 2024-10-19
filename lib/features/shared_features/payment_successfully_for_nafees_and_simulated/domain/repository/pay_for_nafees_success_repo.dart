import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/failure/failure.dart';

abstract class PaymentForNafeesSuccessBaseRepository {
  Future<Either<Failure, String>> savePaymentForNafeesToServer(
      PaySuccessForNafeesParameters parameter);
}

class PaySuccessForNafeesParameters extends Equatable {
  final int childId;
  final int? nafeesId;
  final int? simulatedId;
  final bool isNafees;

  const PaySuccessForNafeesParameters(
      {required this.childId,
      required this.isNafees,
        this.nafeesId,
        this.simulatedId,
      });

  @override
  List<Object?> get props => [
        childId,
    isNafees,
       nafeesId,
    simulatedId,
      ];
}
