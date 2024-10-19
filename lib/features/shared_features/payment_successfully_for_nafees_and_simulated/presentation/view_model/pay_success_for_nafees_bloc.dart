import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/payment_successfully_for_nafees_and_simulated/domain/use_case/pay_success_for_nafees_use_case.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/use_case/pay_success_use_case.dart';

import 'pay_success_for_nafees_event.dart';
import 'pay_success_for_nafees_state.dart';

@Injectable()
class PaySuccessForNafeesBloc extends Bloc<PaySuccessForNafeesEvent, PaySuccessForNafeesState> {
  final PaymentSuccessForNafeesUseCase paymentSuccessUseCase;
  PaySuccessForNafeesBloc(this.paymentSuccessUseCase) : super(const PaySuccessForNafeesState()) {
    on<AddPaymentToServerForNafeesEvent>(_init);
  }

  void _init(
      AddPaymentToServerForNafeesEvent event, Emitter<PaySuccessForNafeesState> emit) async {
    emit(state.copyWith(addPayState: RequestStates.loading));
    final result = await paymentSuccessUseCase(event.parameters);
    result.fold((l) => emit(state.copyWith(addPayState: RequestStates.error,errorMessage: l.message)),
        (r) => emit(state.copyWith(addPayState: RequestStates.loaded)));
  }
}
