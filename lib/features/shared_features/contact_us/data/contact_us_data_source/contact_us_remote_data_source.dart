import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/contact_us/domain/entity/contact_us_entity.dart';

import '../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../core/api/end_points.dart';
import '../model/contact_us_model.dart';

abstract class ContactUsRemoteDataSource {
  Future<ContactUsEntity> getContactUs();
}

@LazySingleton(
  as: ContactUsRemoteDataSource,
)
class ContactUssRemoteDataSourceImpl implements ContactUsRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;

  ContactUssRemoteDataSourceImpl(this.baseDataSource);

  @override
  Future<ContactUsEntity> getContactUs() async {
    final response = await baseDataSource.postData(
      url: EndPoints.contactUsPath,
      body: {},
    );

    return ContactUsModel.fromJson(response['data']);
  }
}
