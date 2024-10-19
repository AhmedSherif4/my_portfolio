import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';

import '../../../../../../core/failure/failure.dart';
import '../entity/cart_entity.dart';
import '../repository/cart_repository.dart';

@LazySingleton()
class ViewCartUseCase extends BaseUseCase<CartEntity, int> {
  final CartRepository _cartRepository;
  ViewCartUseCase(this._cartRepository);
  @override
  Future<Either<Failure, CartEntity>> call(int parameter) async {
    return await _cartRepository.viewCartData(parameter);
  }
}
