part of '../../terms_and_conditions.dart';


abstract class GetTermsAndConditionsLocalDataSource {
  Future<void> saveTermsAndCondition({
    required TermsAndConditionsEntity data,
  });

  Future<TermsAndConditionsEntity?> getTermsAndConditions();
}

@LazySingleton(as: GetTermsAndConditionsLocalDataSource)
class GetTermsAndConditionsLocalDataSourceImpl
    implements GetTermsAndConditionsLocalDataSource {
  final BaseLocalDataSource localDataSource;

  const GetTermsAndConditionsLocalDataSourceImpl(
      {required this.localDataSource});

  @override
  Future<TermsAndConditionsEntity?> getTermsAndConditions() async {
    await Hive.openBox<String>(
        AppKeys.getExpirationKey(AppKeys.termsAndConditions));
    await Hive.openBox<TermsAndConditionsEntity>(AppKeys.termsAndConditions);

    final termsAndCondition =
        await localDataSource.getDataFromLocal<TermsAndConditionsEntity>(
      labelKey: AppKeys.termsAndConditions,
    );
    if (termsAndCondition == null) {
      return null;
    } else {
      return termsAndCondition;
    }
  }

  @override
  Future<void> saveTermsAndCondition(
      {required TermsAndConditionsEntity data}) async {

    try {
      final dataExpirationBox =
      Hive.box<String>(AppKeys.getExpirationKey(AppKeys.termsAndConditions));
      dataExpirationBox.put(
        AppKeys.getExpirationKey(AppKeys.termsAndConditions),
        DateTime.now()
            .add(const Duration(days: AppConstants.appLocalDurationInDays))
            .toIso8601String(),
      );
      final dataBox = Hive.box<TermsAndConditionsEntity>(
        AppKeys.termsAndConditions,
      );

      dataBox.put(AppKeys.termsAndConditions, data);
    }on HiveError {
      rethrow;
    }
  }
}


