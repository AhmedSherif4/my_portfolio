import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import '../../../../../core/failure/failure.dart';
import '../entity/subject_subscriptions_entity.dart';
import '../repository/subject_subscriptions_repository.dart';

@LazySingleton()
class SubjectSubscriptionsUseCase extends BaseUseCase<SubjectSubscriptionsEntity, SubjectSubscriptionsInputs> {
  final SubjectSubscriptionRepository _repository;
  SubjectSubscriptionsUseCase(this._repository);
  @override
  Future<Either<Failure, SubjectSubscriptionsEntity>> call(SubjectSubscriptionsInputs parameter) async {
    return await _repository.getSubjectSubscriptions(parameter);
  }
}
