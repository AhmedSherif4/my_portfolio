import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import '../../../../../../core/failure/failure.dart';
import '../entity/add_delete_subject_entity.dart';
import '../entity/subject_subscriptions_entity.dart';
import '../repository/subject_subscriptions_repository.dart';

@LazySingleton()
class DeleteSubjectUseCase extends BaseUseCase<AddAndDeleteSubjectEntity, AddAndDeleteSubjectInputs>{
  final SubjectSubscriptionRepository _repository;
  DeleteSubjectUseCase(this._repository);

  @override
  Future<Either<Failure, AddAndDeleteSubjectEntity>> call(AddAndDeleteSubjectInputs parameter) async {
    return await _repository.deleteSubject(addAndDeleteSubjectInputs: parameter);
  }
}