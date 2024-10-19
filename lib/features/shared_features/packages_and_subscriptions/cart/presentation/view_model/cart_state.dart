import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

import '../../domain/entity/cart_entity.dart';
class CartState extends Equatable {
  final RequestStates viewCartState;
  final CartEntity cartData;
  final String viewCartMessage;

  final RequestStates deleteCartState;
  final String deleteCartMessage;

  const CartState({
    this.viewCartState = RequestStates.loading,
    this.cartData = const CartEntity(
      cart: [],
      totalPrice: 0,
    ),
    this.deleteCartState = RequestStates.loading,
    this.deleteCartMessage = '',
    this.viewCartMessage = '',
  });

  CartState copyWith({
    RequestStates? viewCartState,
    CartEntity? cartData,
    String? viewCartMessage,
    RequestStates? deleteCartState,
    String? deleteCartMessage,
  }) {
    return CartState(
      viewCartState: viewCartState ?? this.viewCartState,
      cartData: cartData ?? this.cartData,
      viewCartMessage: viewCartMessage ?? this.viewCartMessage,
      deleteCartState: deleteCartState ?? this.deleteCartState,
      deleteCartMessage: deleteCartMessage ?? this.deleteCartMessage,
    );
  }

  @override
  List<Object?> get props => [
        viewCartState,
        cartData,
        viewCartMessage,
        deleteCartMessage,
        deleteCartState,
      ];
}
