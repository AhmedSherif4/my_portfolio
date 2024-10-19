import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../child_subscriptions_base_repository/child_subscriptions_base_repository.dart';
import '../entity/child_subscriptions_studying_entity.dart';

@LazySingleton()
class GetChildSubscriptionsPathsUseCase extends BaseUseCase<
    List<ChildSubscriptionsStudyingEntity>,
    GetChildSubscriptionsTermsOrPathsParameters> {
  final ChildSubscriptionsBaseRepository repository;

  GetChildSubscriptionsPathsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ChildSubscriptionsStudyingEntity>>> call(
      GetChildSubscriptionsTermsOrPathsParameters parameter) async {
    return await repository.getChildSubscriptionsPaths(parameters: parameter);
  }
}
