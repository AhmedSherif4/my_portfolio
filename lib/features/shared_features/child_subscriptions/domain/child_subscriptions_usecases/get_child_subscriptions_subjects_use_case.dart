import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/child_flow/home/domain/home_entities/subjects_entity.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_question_parameter.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../child_subscriptions_base_repository/child_subscriptions_base_repository.dart';

@LazySingleton()
class GetChildSubscriptionsSubjectsUseCase
    extends BaseUseCase<List<SubjectsEntity>, ParameterGoToQuestions> {
  final ChildSubscriptionsBaseRepository repository;

  GetChildSubscriptionsSubjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SubjectsEntity>>> call(
      ParameterGoToQuestions parameter) async {
    return await repository.getChildSubscriptionsSubjects(
        subjectsParameters: parameter);
  }
}
