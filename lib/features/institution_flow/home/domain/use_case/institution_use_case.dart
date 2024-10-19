import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/institution_flow/home/domain/repository/institution_repo.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../../core/usecase/base_usecase.dart';

@LazySingleton()
class GetAllParentsForInstitutionUseCase
    extends BaseUseCase<List<UserEntity>, NoParameter> {
  final InstitutionHomeBaseRepository repository;

  GetAllParentsForInstitutionUseCase({required this.repository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParameter parameter) async {
    return await repository.getAllParentsForInstitution();
  }
}
