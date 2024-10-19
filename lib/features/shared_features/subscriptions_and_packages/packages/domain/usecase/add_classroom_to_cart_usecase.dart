import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/model/add_classroom_model.dart';
import '../repository/packages_repository.dart';

@LazySingleton()
class AddClassRoomToCartUseCase extends BaseUseCase<AddClassroomModelHaveTermsAndOptionalSubjects, AddItemToCartParameters> {
  final PackagesRepository repository;

  AddClassRoomToCartUseCase({required this.repository});

  @override
  Future<Either<Failure, AddClassroomModelHaveTermsAndOptionalSubjects>> call(AddItemToCartParameters parameter) async {
    return await repository.addClassroomToCart(addItemToCartParameters: parameter);
  }
}