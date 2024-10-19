
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enum/enum_generation.dart';
import '../../domain/coupon_usecases/coupon_usecase.dart';
import '../coupon_view_model/coupon_event.dart';
import '../coupon_view_model/coupon_state.dart';

@Injectable()
class CouponsBloc extends Bloc<CouponEvent, CouponState> {
  final CouponUseCase couponUseCase;
  CouponsBloc(
   this.couponUseCase,
  ) : super(const CouponState()) {
    on<GetCoupons>(_getCoupon);
  }

  FutureOr<void> _getCoupon(
      GetCoupons event, Emitter<CouponState> emit) async {
    emit(state.copyWith(
      getCouponsRequestState: RequestStates.loading,
    ));
    final result = await couponUseCase(event.childId);
    result.fold(
      (l) => emit(
        state.copyWith(
          getCouponsRequestState: RequestStates.error,
          getCouponsErrorMessage: l.message,
        ),
      ),
      (coupons) => emit(
        state.copyWith(
          getCouponsRequestState: RequestStates.loaded,
          coupons: coupons,
        ),
      ),
    );
  }
}
