import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart';
import 'package:my_portfolio/config/notification/notification_setup.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_models/auth_entity/auth_entity.dart';
import 'package:my_portfolio/features/auth/shared_screens/verification/data/model/sign_up_model.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../domain/social_register_usecases/social_register_usecase.dart';

abstract class SocialRegisterBaseRemoteDataSource {
  Future<AuthEntity> socialRegister(
      {required SocialRegisterData signUpParameter});
}

@LazySingleton(
  as: SocialRegisterBaseRemoteDataSource,
)
class SocialRegisterRemoteDataSourceImpl
    implements SocialRegisterBaseRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;

  SocialRegisterRemoteDataSourceImpl({required this.baseDataSource});

  @override
  Future<AuthEntity> socialRegister({
    required SocialRegisterData signUpParameter,
  }) async {
    final response = await baseDataSource.postData(
      url: EndPoints.socialRegisterPath,
      body: signUpParameter.type == UsersType.child.name
          ? {
              "name": signUpParameter.displayName,
              "email": signUpParameter.email,
              'social_id': signUpParameter.socialId,
              "type": signUpParameter.type,
              "gendar": signUpParameter.gender,
              "mobile_id": await AppReference.getMobileID(),
              "noti_id":
                  await NotificationSetup.getNotificationTokenFromFireBase(),
              "img": signUpParameter.photoUrl,
            }
          : {
              "name": signUpParameter.displayName,
              "email": signUpParameter.email,
              'social_id': signUpParameter.socialId,
              "type": signUpParameter.type,
              "gendar": signUpParameter.gender,
              "noti_id":
                  await NotificationSetup.getNotificationTokenFromFireBase(),
              "img": signUpParameter.photoUrl,
            },
    );
    return SignUpModel.fromMap(response);
  }
}
