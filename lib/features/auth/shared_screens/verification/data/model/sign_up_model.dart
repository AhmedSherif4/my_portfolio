import 'package:my_portfolio/core/shared_models/auth_entity/auth_entity.dart';
import 'package:my_portfolio/core/shared_models/user/user_model/user_model.dart';

class SignUpModel extends AuthEntity {
  const SignUpModel({
    required super.user,
    required super.token,
    required super.message,
  });

  @override
  String toString() => 'SignUpModel(user: $user, token: $token)';

  factory SignUpModel.fromMap(Map<String, dynamic> json) {
    return SignUpModel(
      user: UserModel.fromMap(json['data']['register_data']),
      token: json['data']['token'] as String,
      message: json['message'] ?? '',
    );
  }

}
