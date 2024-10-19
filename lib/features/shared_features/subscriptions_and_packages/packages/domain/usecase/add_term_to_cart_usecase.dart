import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/model/add_classroom_model.dart';
import '../repository/packages_repository.dart';

@LazySingleton()
class AddTermToCartUseCase extends BaseUseCase<AddTermModelHaveOptionalSubjects, AddItemToCartParameters> {
  final PackagesRepository repository;

  AddTermToCartUseCase({required this.repository});

  @override
  Future<Either<Failure, AddTermModelHaveOptionalSubjects>> call(AddItemToCartParameters parameter) async {
    return await repository.addTermToCart(addItemToCartParameters: parameter);
  }
}