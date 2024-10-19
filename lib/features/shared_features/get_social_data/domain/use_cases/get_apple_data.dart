import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/failure/failure.dart';
import '../entity/social_login_data_entity.dart';
import '../get_social_base_repository/get_social_base_repository.dart';

@LazySingleton()
class GetAppleDataUseCase {
  final GetSocialDataBaseRepository getSocialDataBaseRepository;

  GetAppleDataUseCase({
    required this.getSocialDataBaseRepository,
  });

  Future<Either<Failure, SocialLoginDataEntity>> call() async {
    return await getSocialDataBaseRepository.getAppleData();
  }
}




