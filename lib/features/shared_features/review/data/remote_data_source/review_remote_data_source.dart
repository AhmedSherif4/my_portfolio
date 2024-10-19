import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/features/shared_features/review/data/model/review_model.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../domain/entity/add_review_entity_inputs.dart';
import '../../domain/entity/review_entity_outputs.dart';

abstract class ReviewRemoteDataSource {
  Future<String> deleteReviewData({required int reviewID});
  Future<String> addReviewData({required AddReviewInputs addReviewInputs});
  Future<List<ReviewEntityOutputs>> getAllReviewData();
}

@LazySingleton(as: ReviewRemoteDataSource)
class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final BaseRemoteDataSource _dataSource;

  ReviewRemoteDataSourceImpl(this._dataSource);

  @override
  Future<String> addReviewData(
      {required AddReviewInputs addReviewInputs}) async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()
            ? EndPoints.childAddReviewPath
            : AppReference.userIsParent()
                ? EndPoints.parentAddReviewPath
                : EndPoints.institutionAddReviewPath,
        body: {
          'review_text': addReviewInputs.reviewText,
          'stars_num': addReviewInputs.starsNum,
        });

    return response['message'] ?? "لقد تم إضافة تقيميك بنجاح";
  }

  @override
  Future<String> deleteReviewData({required int reviewID}) async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()
            ? EndPoints.childDeleteReviewPath
            : AppReference.userIsParent()
                ? EndPoints.parentDeleteReviewPath
                : EndPoints.institutionDeleteReviewPath,
        body: {
          'review_id': '$reviewID',
        });

    return response['data'];
  }

  @override
  Future<List<ReviewEntityOutputs>> getAllReviewData() async {
    final response = await _dataSource.postData(
        url: AppReference.userIsChild()
            ? EndPoints.childAllReviewPath
            : AppReference.userIsParent()
                ? EndPoints.parentAllReviewPath
                : EndPoints.institutionAllReviewPath,
        body: {});
    final reviews = List<ReviewEntityOutputs>.from((response['data'] as List)
        .map((element) => ReviewModel.fromJson(element))).toList();

    return reviews;
  }
}
