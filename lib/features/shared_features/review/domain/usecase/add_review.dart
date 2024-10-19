import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../entity/add_review_entity_inputs.dart';
import '../repository/review_repository.dart';



@LazySingleton()
class AddReviewUseCase extends BaseUseCase<String, AddReviewInputs>{
  final ReviewRepository _repository;
  AddReviewUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(AddReviewInputs parameter) async {
    return await _repository.addReview(addReviewInputs: parameter);
  }
}