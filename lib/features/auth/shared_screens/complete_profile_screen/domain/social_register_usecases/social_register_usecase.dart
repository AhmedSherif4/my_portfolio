import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/shared_models/auth_entity/auth_entity.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';

import '../social_register_base_repository/social_register_base_repository.dart';

@LazySingleton()
class SocialRegisterCodeUseCase
    extends BaseUseCase<AuthEntity, SocialRegisterData> {
  final SocialRegisterBaseRepository repository;

  SocialRegisterCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthEntity>> call(SocialRegisterData parameter) {
    return repository.socialRegister(signUpParameter: parameter);
  }
}

class SocialRegisterData extends Equatable {
  final String email;
  final String displayName;
  final String photoUrl;
  final String socialId;
  final String type;
  final String gender;

  const SocialRegisterData({
    this.email = '',
    required this.displayName,
    required this.photoUrl,
    required this.socialId,
    this.type = '',
    this.gender = '',
  });

  @override
  List<Object?> get props => [
        email,
        displayName,
        socialId,
        photoUrl,
        gender,
        type,
      ];
}
