import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../get_social_data/domain/entity/social_login_data_entity.dart';
import '../social_login_base_repository/social_login_base_repository.dart';


@LazySingleton()
class GetGoogleIdAndUserDataByGoogleAccountUseCase {
  final SocialLoginBaseRepository socialLoginBaseRepository;

  GetGoogleIdAndUserDataByGoogleAccountUseCase({
    required this.socialLoginBaseRepository,
  });

  Future<Either<Failure, SocialLoginDataEntity>> call() async {
    return await socialLoginBaseRepository.getGoogleIdAndUserDataByGoogleAccount();
  }
}




