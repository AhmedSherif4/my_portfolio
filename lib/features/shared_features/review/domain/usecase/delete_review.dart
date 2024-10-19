import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import '../../../../../../core/failure/failure.dart';
import '../repository/review_repository.dart';



@LazySingleton()
class DeleteReviewUseCase extends BaseUseCase<String, int>{
  final ReviewRepository _repository;
  DeleteReviewUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(int parameter) async {
    return await _repository.deleteReview(reviewID: parameter);
  }
}