import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/contact_us/domain/entity/contact_us_entity.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../contact_us_base_repository/contact_us_base_repository.dart';

@LazySingleton()
class GetContactUsUseCase extends BaseUseCase<ContactUsEntity, NoParameter> {
  final ContactUsBaseRepository repository;

  GetContactUsUseCase({required this.repository});

  @override
  Future<Either<Failure, ContactUsEntity>> call(NoParameter parameter) async {
    return await repository.getContacts();
  }
}
