import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';

import '../../../../../../core/failure/failure.dart';
import '../repository/cart_repository.dart';

@LazySingleton()
class DeleteAllDataInCartUseCase extends BaseUseCase<String, int>{
  final CartRepository _repository;
  DeleteAllDataInCartUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(int parameter) async {
    return await _repository.deleteAllDataInCart(parameter);
  }
}