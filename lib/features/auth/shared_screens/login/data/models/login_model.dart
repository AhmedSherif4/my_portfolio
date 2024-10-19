
import 'package:my_portfolio/core/shared_models/auth_entity/auth_entity.dart';
import 'package:my_portfolio/core/shared_models/user/user_model/user_model.dart';

class LoginModel extends AuthEntity {
  const LoginModel({
    required super.user,
    required super.token,
    required super.message,
  });

  @override
  String toString() => 'LoginModel(user: $user, token: $token)';

  factory LoginModel.fromMap(Map<String, dynamic> json) {
    return LoginModel(
      user: UserModel.fromMap(json['data']['login_data']),
      token: json['data']['token'] as String,
      message: json['message'] ?? '',
    );
  }

}
