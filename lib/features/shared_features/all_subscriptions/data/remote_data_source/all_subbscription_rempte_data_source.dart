import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/entity/all_subscription_entity.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../core/api/end_points.dart';

abstract class AllSubscriptionRemoteDataSource {
  Future<List<AllSubscriptionModel>> getAllSubscription(
      {required int? childId});
}

@LazySingleton(as: AllSubscriptionRemoteDataSource)
class AllSubscriptionRemoteDataSourceImpl
    extends AllSubscriptionRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  AllSubscriptionRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<List<AllSubscriptionModel>> getAllSubscription(
      {required int? childId}) async {
    final response = AppReference.userIsChild()
        ? await baseRemoteDataSource
            .postData(url: EndPoints.allSubscription, body: {})
        : await baseRemoteDataSource.postData(
            url: AppReference.userIsParent()
                ? EndPoints.parentAllSubscription
                : EndPoints.institutionAllSubscription,
            body: {
                'child_id': childId,
              });
    final allSubscription = response['data'] == null
        ? const <AllSubscriptionModel>[]
        : List<AllSubscriptionModel>.from((response['data'] as List)
            .map((element) => AllSubscriptionModel.fromJson(element)));

    return allSubscription;
  }
}
