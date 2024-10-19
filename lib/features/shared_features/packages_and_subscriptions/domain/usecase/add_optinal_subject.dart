import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../entity/subject_subscriptions_entity.dart';
import '../repository/subject_subscriptions_repository.dart';

@LazySingleton()
class AddOptionalSubjectUseCase extends BaseUseCase<String, AddAndDeleteSubjectInputs>{
  final SubjectSubscriptionRepository _repository;
  AddOptionalSubjectUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(AddAndDeleteSubjectInputs parameter) async {
    return await _repository.addOptionalSubject(addAndDeleteSubjectInputs: parameter);
  }
}