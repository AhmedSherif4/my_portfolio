import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../repository/packages_repository.dart';

@LazySingleton()
class AddSubjectToCartUseCase extends BaseUseCase<String, AddItemToCartParameters> {
  final PackagesRepository repository;

  AddSubjectToCartUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(AddItemToCartParameters parameter) async {
    return await repository.addSubjectToCart(addItemToCartParameters: parameter);
  }
}