import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../child_subscriptions_base_repository/child_subscriptions_base_repository.dart';
import '../entity/child_subscriptions_studying_entity.dart';

@LazySingleton()
class GetChildSubscriptionsSystemsUseCase
     extends BaseUseCase<List<ChildSubscriptionsStudyingEntity>, int?> {
  final ChildSubscriptionsBaseRepository repository;

  GetChildSubscriptionsSystemsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>> call(
      parameter) async {
    return await repository.getChildSubscriptionsSystems(childId: parameter);
  }
}


