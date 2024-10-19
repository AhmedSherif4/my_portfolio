import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/usecase/add_classroom_to_cart_usecase.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/usecase/add_subject_to_cart_usecase.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/usecase/add_term_to_cart_usecase.dart';
import 'packages_event.dart';
import 'packages_state.dart';

@Injectable()
class PackagesBloc extends Bloc<PackagesEvent, PackagesState> {
  final AddClassRoomToCartUseCase addClassRoomToCartUseCase;
  final AddTermToCartUseCase addTermToCartUseCase;
  final AddSubjectToCartUseCase addSubjectToCartUseCase;
  PackagesBloc(
    this.addClassRoomToCartUseCase,
    this.addTermToCartUseCase,
    this.addSubjectToCartUseCase,
  ) : super(const PackagesState()) {
    on<AddClassroomToCartEvent>(_addClassroomToCart);
    on<AddTermToCartEvent>(_addTermToCart);
    on<AddSubjectToCartEvent>(_addSubjectToCart);
  }

  void _addClassroomToCart(AddClassroomToCartEvent event, Emitter<PackagesState> emit) async {
    emit(state.copyWith(
      addClassroomToCartState: RequestStates.loading,
      addTermToCartState: RequestStates.initial,
      addSubjectToCartState: RequestStates.initial,
    ));
    final result = await addClassRoomToCartUseCase(event.addItemToCartParameters);

    result.fold(
      (l) => emit(state.copyWith(addClassroomToCartState: RequestStates.error, addClassroomToCartMessage: l.message.toString())),
      (r) => emit(state.copyWith(addClassroomToCartState: RequestStates.loaded, addClassroomToCartData: r)),
    );
  }

  void _addTermToCart(AddTermToCartEvent event, Emitter<PackagesState> emit) async {
    emit(state.copyWith(
      addTermToCartState: RequestStates.loading,
      addClassroomToCartState: RequestStates.initial,
      addSubjectToCartState: RequestStates.initial,
    ));
    final result = await addTermToCartUseCase(event.addItemToCartParameters);

    result.fold(
      (l) => emit(state.copyWith(addTermToCartState: RequestStates.error, addTermToCartMessage: l.message.toString())),
      (r) => emit(state.copyWith(addTermToCartState: RequestStates.loaded, addTermToCartData: r)),
    );
  }

  void _addSubjectToCart(AddSubjectToCartEvent event, Emitter<PackagesState> emit) async {
    emit(state.copyWith(
      addSubjectToCartState: RequestStates.loading,
      addTermToCartState: RequestStates.initial,
      addClassroomToCartState: RequestStates.initial,
    ));
    final result = await addSubjectToCartUseCase(event.addItemToCartParameters);

    result.fold(
      (l) => emit(state.copyWith(addSubjectToCartState: RequestStates.error, addSubjectToCartMessage: l.message.toString())),
      (r) => emit(state.copyWith(addSubjectToCartState: RequestStates.loaded, addSubjectToCartMessage: r)),
    );
  }


}
