import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/use_case/pay_success_use_case.dart';

import 'pay_success_event.dart';
import 'pay_success_state.dart';

@Injectable()
class PaySuccessBloc extends Bloc<PaySuccessEvent, PaySuccessState> {
  final PaymentSuccessUseCase paymentSuccessUseCase;
  PaySuccessBloc(this.paymentSuccessUseCase) : super(const PaySuccessState()) {
    on<AddPaymentToServerEvent>(_init);
  }

  void _init(
      AddPaymentToServerEvent event, Emitter<PaySuccessState> emit) async {
    emit(state.copyWith(addPayState: RequestStates.loading));
    final result = await paymentSuccessUseCase(event.parameters);
    result.fold((l) => emit(state.copyWith(addPayState: RequestStates.error,errorMessage: l.message)),
        (r) => emit(state.copyWith(addPayState: RequestStates.loaded)));
  }
}
