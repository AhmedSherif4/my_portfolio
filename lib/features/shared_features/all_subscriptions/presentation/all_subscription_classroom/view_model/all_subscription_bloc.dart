import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/entity/all_subscription_entity.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/use_case/all_subscription_use_case.dart';

part 'all_subscription_event.dart';
part 'all_subscription_state.dart';

@Injectable()
class AllSubscriptionBloc
    extends Bloc<AllSubscriptionEvent, AllSubscriptionState> {
  final GetAllSubscriptionUseCase getAllSubscriptionUseCase;

  AllSubscriptionBloc(this.getAllSubscriptionUseCase)
      : super(const AllSubscriptionState()) {
    on<GetAllSubscriptionEvent>((event, emit) async {
      emit(state.copyWith(getAllSubscriptionState: RequestStates.loading));
      final result = await getAllSubscriptionUseCase(event.childId);
      result.fold(
        (l) => emit(
          state.copyWith(
            getAllSubscriptionState: RequestStates.error,
            getAllSubscriptionErrorMessage: l.message.toString(),
          ),
        ),
        (r) => emit(
          state.copyWith(
            getAllSubscriptionState: RequestStates.loaded,
            allSubscription: r,
          ),
        ),
      );
    });
  }
}
