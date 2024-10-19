import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/core/shared_models/user/user_model/user_model.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';

abstract class ParentHomeRemoteDataSource {
  Future<List<UserEntity>> getAllChildForParent({int? parentId});
}

@LazySingleton(
  as: ParentHomeRemoteDataSource,
)
class ParentHomeRemoteDataSourceImpl implements ParentHomeRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;

  ParentHomeRemoteDataSourceImpl(this.baseDataSource);

  @override
  Future<List<UserEntity>> getAllChildForParent({int? parentId}) async {
    final response = AppReference.userIsParent()
        ? await baseDataSource.postData(
            url: EndPoints.allChildForParentPath,
            body: {},
          )
        : await baseDataSource.postData(
            url: EndPoints.institutionAllChildForParentPath,
            body: {
              'parent_id': parentId,
            },
          );

    final allChild =
        List<UserEntity>.from((response['data'] as List).map((element) {
      return UserModel.fromMap(element);
    })).toList();

    return allChild;
  }
}
