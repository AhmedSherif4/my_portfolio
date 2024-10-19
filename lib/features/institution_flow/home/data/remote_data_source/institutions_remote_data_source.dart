import 'package:injectable/injectable.dart';

import '../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../../core/shared_models/user/user_model/user_model.dart';

abstract class InstitutionHomeRemoteDataSource {
  Future<List<UserEntity>> getAllParentsForInstitution();
}

@LazySingleton(
  as: InstitutionHomeRemoteDataSource,
)
class InstitutionHomeRemoteDataSourceImpl
    implements InstitutionHomeRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;

  InstitutionHomeRemoteDataSourceImpl(this.baseDataSource);

  @override
  Future<List<UserEntity>> getAllParentsForInstitution() async {
    final response = await baseDataSource.postData(
      url: EndPoints.allParentsForInstitutionPath,
      body: {},
    );

    final allChild =
        List<UserEntity>.from((response['data'] as List).map((element) {
      return UserModel.fromMap(element);
    })).toList();

    return allChild;
  }
}
