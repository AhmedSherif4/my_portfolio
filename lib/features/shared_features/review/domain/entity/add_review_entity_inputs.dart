import 'package:equatable/equatable.dart';

class AddReviewInputs extends Equatable {
  final String reviewText;
  final int starsNum;
  const AddReviewInputs({
    this.reviewText = '',
    this.starsNum = 0,
  });

  @override
  List<Object?> get props => [reviewText, starsNum];

  AddReviewInputs copyWith({
    String? reviewText,
    int? starsNum,
  }) {
    return AddReviewInputs(
      reviewText: reviewText ?? this.reviewText,
      starsNum: starsNum ?? this.starsNum,
    );
  }
}
