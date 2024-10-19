import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/domain/use_case/add_parent_use_case.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../../core/enum/enum_generation.dart';

abstract class AddParentRemoteDataSource {
  Future<String> addParent({
    required AddParentParameter addParentParameter,
  });
}

@LazySingleton(
  as: AddParentRemoteDataSource,
)
class AddParentRemoteDataSourceImpl implements AddParentRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;
  final ApiConsumer apiConsumer;

  const AddParentRemoteDataSourceImpl(
      {required this.apiConsumer, required this.baseDataSource});

  @override
  Future<String> addParent(
      {required AddParentParameter addParentParameter}) async {
    final response = await baseDataSource.postData(
      url: EndPoints.institutionAddNewParent,
      body: FormData.fromMap({
        "name": addParentParameter.name,
        "email": addParentParameter.sendType == SendType.email
            ? addParentParameter.emailOrPhone : null,
        "password": addParentParameter.password,
        "phone":  addParentParameter.emailOrPhone,
        "gendar": addParentParameter.gendar,
        "img": addParentParameter.img.isNotEmpty
            ? await MultipartFile.fromFile(addParentParameter.img)
            : null,
      }),
    );
    return response['message'];
  }
}
