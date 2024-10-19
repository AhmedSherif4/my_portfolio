import 'package:equatable/equatable.dart';

class SocialLoginDataEntity extends Equatable {
  final String email;
  final String displayName;
  final String photoUrl;
  final String socialId;

  const SocialLoginDataEntity({
    this.email = '',
    required this.displayName,
    required this.photoUrl,
    required this.socialId,
  });

  @override
  List<Object?> get props => [
        email,
        displayName,
        socialId,
        photoUrl,
      ];
}
