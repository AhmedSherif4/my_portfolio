import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../entity/review_entity_outputs.dart';
import '../repository/review_repository.dart';

@LazySingleton()
class GetAllReviewUseCase extends BaseUseCase<List<ReviewEntityOutputs>, NoParameter>{
  final ReviewRepository _repository;
  GetAllReviewUseCase(this._repository);

  @override
  Future<Either<Failure, List<ReviewEntityOutputs>>> call(parameter) async {
    return await _repository.getAllReviews();
  }
}

