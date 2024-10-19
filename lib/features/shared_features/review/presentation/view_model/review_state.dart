import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/review/domain/entity/review_entity_outputs.dart';

class ReviewState extends Equatable {
  final RequestStates reviewsState;
  final List<ReviewEntityOutputs> reviews;
  final String viewReviewMessage;

  final RequestStates deleteReviewState;
  final String deleteReviewMessage;

  final RequestStates addReviewState;
  final String addReviewMessage;

  const ReviewState({
    this.reviewsState = RequestStates.loading,
    this.reviews = const[],
    // const ReviewEntityOutputs(
    //   starsNum: "0",
    //   reviewText: "",
    //   createdAt: "",
    //   id: 0, childId: 0,
    //   institutionId: 0,
    //   parentId: 0,
    //   isDeleted: "",
    //   response: [],
    //   status: "",
    //   updatedAt: "",
    // ),
    this.viewReviewMessage = "",
    this.deleteReviewState = RequestStates.initial,
    this.deleteReviewMessage = "",
    this.addReviewState = RequestStates.initial,
    this.addReviewMessage = "",
  });

  ReviewState copyWith({
    RequestStates? reviewsState,
    List<ReviewEntityOutputs>? reviews,
    String? viewReviewMessage,

    RequestStates? deleteReviewState,
    String? deleteReviewMessage,

    RequestStates? addReviewState,
    String? addReviewMessage,
  }) {
    return ReviewState(
      reviewsState: reviewsState ?? this.reviewsState,
      reviews: reviews ?? this.reviews,
      viewReviewMessage: viewReviewMessage ?? this.viewReviewMessage,
      deleteReviewState: deleteReviewState ?? this.deleteReviewState,
      deleteReviewMessage: deleteReviewMessage ?? this.deleteReviewMessage,
      addReviewState: addReviewState ?? this.addReviewState,
      addReviewMessage: addReviewMessage ?? this.addReviewMessage,
    );
  }

  @override
  List<Object?> get props => [
        reviewsState,
        reviews,
        viewReviewMessage,
        deleteReviewState,
        deleteReviewMessage,
        addReviewState,
        addReviewMessage,
      ];
}
