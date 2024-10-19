import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import '../entity/add_review_entity_inputs.dart';
import '../entity/review_entity_outputs.dart';


abstract class ReviewRepository{

  Future<Either<Failure, String>> deleteReview({required int reviewID});

  Future<Either<Failure, String>> addReview({required AddReviewInputs addReviewInputs});

  Future<Either<Failure, List<ReviewEntityOutputs>>> getAllReviews();
}

