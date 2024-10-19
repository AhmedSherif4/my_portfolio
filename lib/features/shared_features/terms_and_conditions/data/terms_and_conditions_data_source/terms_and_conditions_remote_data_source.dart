part of '../../terms_and_conditions.dart';


abstract class TermsAndConditionsRemoteDataSource {
  Future<TermsAndConditionsEntity> getTermsAndCondition();
}

@LazySingleton(
  as: TermsAndConditionsRemoteDataSource,
)
class TermsAndConditionsRemoteDataSourceImpl
    implements TermsAndConditionsRemoteDataSource {
  final BaseRemoteDataSource baseDataSource;

  TermsAndConditionsRemoteDataSourceImpl(this.baseDataSource);

  @override
  Future<TermsAndConditionsEntity> getTermsAndCondition() async {
    final response = await baseDataSource.postData(
      url: EndPoints.termsAndConditionsPath,
      body: {},
    );
    return TermsAndConditionsModel.fromJson(response['data']);
  }
}
