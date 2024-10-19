import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/features/shared_features/review/domain/entity/review_entity_outputs.dart';
import 'package:my_portfolio/features/shared_features/review/domain/entity/add_review_entity_inputs.dart';
import '../../domain/repository/review_repository.dart';
import '../remote_data_source/review_remote_data_source.dart';

@LazySingleton(as:ReviewRepository )
class ReviewRepositoryImpl implements ReviewRepository {
  final BaseRepository _baseRepository;
  final ReviewRemoteDataSource _remoteDataSource;

  ReviewRepositoryImpl(this._baseRepository, this._remoteDataSource);

  @override
  Future<Either<Failure, String>> addReview({required AddReviewInputs addReviewInputs}) async{
    final response =
        await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.addReviewData(addReviewInputs: addReviewInputs));
    return response;
  }

  @override
  Future<Either<Failure, String>> deleteReview({required int reviewID}) async{
    final response =
        await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.deleteReviewData(reviewID: reviewID));
    return response;
  }

  @override
  Future<Either<Failure, List<ReviewEntityOutputs>>> getAllReviews() async{
    final response =
    await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.getAllReviewData());
    return response;
  }


}
