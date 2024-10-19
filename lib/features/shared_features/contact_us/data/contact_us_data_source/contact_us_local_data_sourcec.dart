import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_local_data_source/base_local_data_source.dart';
import 'package:my_portfolio/features/shared_features/contact_us/domain/entity/contact_us_entity.dart';

import '../../../../../../config/storages/keys.dart';
import '../../../../../config/resources/app_constants.dart';

abstract class GetContactUsLocalDataSource {
  Future<void> saveContactUs({
    required ContactUsEntity data,
  });

  Future<ContactUsEntity?> getContactUs();
}

@LazySingleton(as: GetContactUsLocalDataSource)
class GetContactUsLocalDataSourceImpl implements GetContactUsLocalDataSource {
  final BaseLocalDataSource localDataSource;

  const GetContactUsLocalDataSourceImpl({required this.localDataSource});

  @override
  Future<ContactUsEntity?> getContactUs() async {
    await Hive.openBox<String>(AppKeys.getExpirationKey(AppKeys.contactUs));
    await Hive.openBox<ContactUsEntity>(AppKeys.contactUs);
    final contactUs = await localDataSource.getDataFromLocal<ContactUsEntity>(
      labelKey: AppKeys.contactUs,
    );
    if (contactUs == null) {
      return null;
    } else {
      return contactUs;
    }
  }

  @override
  Future<void> saveContactUs({required ContactUsEntity data}) async {
    try {
      final dataExpirationBox =
      Hive.box<String>(AppKeys.getExpirationKey(AppKeys.contactUs));
      dataExpirationBox.put(
        AppKeys.getExpirationKey(AppKeys.contactUs),
        DateTime.now()
            .add(const Duration(days: AppConstants.appLocalDurationInDays))
            .toIso8601String(),
      );
      final dataBox = Hive.box<ContactUsEntity>(
        AppKeys.contactUs,
      );

      dataBox.put(AppKeys.contactUs, data);
    }on HiveError {
      rethrow;
    }
  }
}
