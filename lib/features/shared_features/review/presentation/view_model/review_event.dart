import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/shared_features/review/domain/entity/add_review_entity_inputs.dart';

abstract class ReviewEvent extends Equatable{}

class GetAllReviewDataEvent extends ReviewEvent {
  GetAllReviewDataEvent();
  @override
  List<Object> get props => [];
}
class DeleteReviewDataEvent extends ReviewEvent {
  final int reviewID;

  DeleteReviewDataEvent({required this.reviewID});


  @override
  List<Object> get props => [
    reviewID
  ];
}
class AddReviewDataEvent extends ReviewEvent {
  final AddReviewInputs addReviewInputs;

  AddReviewDataEvent({required this.addReviewInputs});


  @override
  List<Object> get props => [
    addReviewInputs
  ];
}