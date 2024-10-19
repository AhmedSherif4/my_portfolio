import 'package:dartz/dartz.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/entity/all_subscription_entity.dart';

import '../../../../../core/failure/failure.dart';

abstract class AllSubscriptionRepository {
  Future<Either<Failure, List<AllSubscriptionModel>>> getAllSubscription({
    required int? childId,
  });
}
