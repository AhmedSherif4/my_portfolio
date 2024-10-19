import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/entity/all_subscription_entity.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/repository/all_subbscription_repo.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';

@LazySingleton()
class GetAllSubscriptionUseCase
    extends BaseUseCase<List<AllSubscriptionModel>, int> {
  final AllSubscriptionRepository repository;

  GetAllSubscriptionUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AllSubscriptionModel>>> call(
      int? parameter) async {
    return await repository.getAllSubscription(childId: parameter);
  }
}
