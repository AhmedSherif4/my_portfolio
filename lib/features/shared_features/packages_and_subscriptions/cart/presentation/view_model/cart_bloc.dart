import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import '../../domain/entity/cart_entity.dart';
import '../../domain/usecase/delete_all_data_in_cart.dart';
import '../../domain/usecase/view_cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';
@Injectable()
class CartBloc extends Bloc<CartEvent, CartState> {
  final ViewCartUseCase _viewCartUseCase;
  final DeleteAllDataInCartUseCase _deleteAllDataInCartUseCase;

  CartBloc(this._viewCartUseCase, this._deleteAllDataInCartUseCase)
      : super(const CartState()) {
    on<ViewCartDataEvent>(_init);
    on<DeleteCartDataEvent>(_deleteAllDataInCart);
  }

  void _init(ViewCartDataEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(
        viewCartState: RequestStates.loading,
        deleteCartState: RequestStates.initial));
    final result = await _viewCartUseCase(event.childID);
    result.fold(
      (l) => emit(state.copyWith(
        viewCartState: RequestStates.error,
        viewCartMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          viewCartState: RequestStates.loaded,
          cartData: r,
        ),
      ),
    );
  }
  void _deleteAllDataInCart(DeleteCartDataEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      deleteCartState: RequestStates.loading,
    ));
    final result = await _deleteAllDataInCartUseCase(event.childID);
    result.fold(
      (l) => emit(state.copyWith(
        deleteCartState: RequestStates.error,
        deleteCartMessage: l.message.toString(),
      )),
      (r) {
        emit(
        state.copyWith(
          deleteCartState: RequestStates.loaded,
          cartData: const CartEntity(
            cart: [],
            totalPrice: 0,
          ),
          deleteCartMessage: r,
        ),
      );
      },
    );
  }
}
