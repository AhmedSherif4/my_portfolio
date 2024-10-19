import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/banner/domain/entity/banner_entity_outputs.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../repository/banner_repository.dart';


@LazySingleton()
class GetBannerUseCase extends BaseUseCase<BannerEntityOutputs?, NoParameter>{
  final BannerRepository _repository;
  GetBannerUseCase(this._repository);

  @override
  Future<Either<Failure, BannerEntityOutputs?>> call(parameter) async {
    return await _repository.getBanner();
  }
}

