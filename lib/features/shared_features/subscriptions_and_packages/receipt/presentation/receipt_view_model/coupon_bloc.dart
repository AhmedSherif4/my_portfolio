import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../domain/check_coupon_usecases/check_coupon_usecase.dart';
import '../../domain/check_coupon_usecases/get_payment_data.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

@Injectable()
class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CheckCouponUseCase checkCouponUseCase;
  final GetPaymentDataUseCase getPaymentDataUseCase;

  CouponBloc(
    this.checkCouponUseCase,
    this.getPaymentDataUseCase,
  ) : super(const CouponState()) {
    on<CheckCouponEvent>(_checkCoupon);
    on<RemoveCouponEvent>(_removeCoupon);
    on<GetPaymentDataEvent>(_getPaymentData);
  }

  late int totalPrice;

  FutureOr<void> _checkCoupon(
      CheckCouponEvent event, Emitter<CouponState> emit) async {
    emit(
      state.copyWith(
        checkCouponState: RequestStates.loading,
        totalPriceAfterCoupon: 0,
      ),
    );
    final result = await checkCouponUseCase(event.coupon);
    result.fold(
      (failure) => emit(
        state.copyWith(
          couponMessage: failure.message,
          checkCouponState: RequestStates.error,
          isApplyCoupon: false,
        ),
      ),
      (coupon) {
        DateTime givenDate = DateTime.parse(coupon.expiryDate);
        DateTime currentDate = DateTime.now();
        if((currentDate.isBefore(givenDate)) && coupon.status && coupon.currentUse < coupon.usages){
          if(coupon.childId != 0){
            if(coupon.childId == getIt<UserLocalDataSource>().getUserData()!.userId){
              if (coupon.discountStart > totalPrice) {
                emit(
                  state.copyWith(
                    couponMessage:
                    'المجموع يجب ألا يكون أقل من ${coupon.discountStart} حتى يمكنك إستخدام الكوبون',
                    checkCouponState: RequestStates.error,
                    isApplyCoupon: false,
                  ),
                );
              } else {
                if (coupon.discountType == 'fixed') {
                  emit(
                    state.copyWith(
                      couponMessage: 'تم تطبيق الكوبون بنجاح',
                      checkCouponState: RequestStates.loaded,
                      isApplyCoupon: true,
                      totalPriceAfterCoupon: totalPrice - coupon.discount,
                      coupon: event.coupon,
                      discount: coupon.discount.toString(),
                    ),
                  );
                } else if (coupon.discountType == 'percent') {
                  emit(
                    state.copyWith(
                      couponMessage: 'تم تطبيق الكوبون بنجاح',
                      checkCouponState: RequestStates.loaded,
                      isApplyCoupon: true,
                      coupon: event.coupon,
                      totalPriceAfterCoupon:
                      totalPrice - (totalPrice * coupon.discount ~/ 100),
                      discount: (totalPrice * coupon.discount ~/ 100).toString(),
                    ),
                  );
                }
              }
            }else{
              emit(
                  state.copyWith(
                    couponMessage: ' كوبون غير صالح ',
                    checkCouponState: RequestStates.error,
                    isApplyCoupon: false,
                    coupon: event.coupon,
                  ));
            }
          } else if (coupon.discountStart > totalPrice) {
            emit(
              state.copyWith(
                couponMessage:
                'المجموع يجب ألا يكون أقل من ${coupon.discountStart} حتى يمكنك إستخدام الكوبون',
                checkCouponState: RequestStates.error,
                isApplyCoupon: false,
              ),
            );
          } else {
            if (coupon.discountType == 'fixed') {
              emit(
                state.copyWith(
                  couponMessage: 'تم تطبيق الكوبون بنجاح',
                  checkCouponState: RequestStates.loaded,
                  isApplyCoupon: true,
                  totalPriceAfterCoupon: totalPrice - coupon.discount,
                  coupon: event.coupon,
                  discount: coupon.discount.toString(),
                ),
              );
            } else if (coupon.discountType == 'percent') {
              emit(
                state.copyWith(
                  couponMessage: 'تم تطبيق الكوبون بنجاح',
                  checkCouponState: RequestStates.loaded,
                  isApplyCoupon: true,
                  coupon: event.coupon,
                  totalPriceAfterCoupon:
                  totalPrice - (totalPrice * coupon.discount ~/ 100),
                  discount: (totalPrice * coupon.discount ~/ 100).toString(),
                ),
              );
            }
          }
        }else{
          emit(
              state.copyWith(
                couponMessage: ' كوبون غير صالح ',
                checkCouponState: RequestStates.error,
                isApplyCoupon: false,
                coupon: event.coupon,
              ));
        }

      },
    );
  }




  FutureOr<void> _removeCoupon(
      RemoveCouponEvent event, Emitter<CouponState> emit) async {
    emit(state.copyWith(
      checkCouponState: RequestStates.initial,
      getPaymentDataState: RequestStates.initial,
      isApplyCoupon: false,
      coupon: '',
      couponMessage: 'تم حذف الكوبون بنجاح',
      totalPriceAfterCoupon: 0,
      discount: '0',
    ));
  }

  FutureOr<void> _getPaymentData(
      GetPaymentDataEvent event, Emitter<CouponState> emit) async {
    emit(state.copyWith(
      getPaymentDataState: RequestStates.loading,
      checkCouponState: RequestStates.initial,
    ));
    final result = await getPaymentDataUseCase(const NoParameter());

    result.fold(
      (l) => emit(state.copyWith(
        getPaymentDataState: RequestStates.error,
      )),
      (r) => emit(
        state.copyWith(
          getPaymentDataState: RequestStates.loaded,
          paymentData: r,
        ),
      ),
    );
  }
}
