import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import 'package:my_portfolio/features/shared_features/review/domain/usecase/add_review.dart';
import 'package:my_portfolio/features/shared_features/review/domain/usecase/all_reviews.dart';
import 'package:my_portfolio/features/shared_features/review/domain/usecase/delete_review.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_event.dart';
import 'review_state.dart';

@Injectable()
class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final GetAllReviewUseCase _getAllReviewUseCase;
  final AddReviewUseCase _addReviewUseCase;
  final DeleteReviewUseCase _deleteReviewUseCase;

  ReviewBloc(this._getAllReviewUseCase, this._addReviewUseCase, this._deleteReviewUseCase)
      : super(const ReviewState()) {
    on<GetAllReviewDataEvent>(_getAllReview);
    on<AddReviewDataEvent>(_addReview);
    on<DeleteReviewDataEvent>(_deleteReview);}

  void _getAllReview(GetAllReviewDataEvent event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(
        reviewsState: RequestStates.loading,
        addReviewState: RequestStates.initial,
        deleteReviewState: RequestStates.initial));
    final result = await _getAllReviewUseCase(const NoParameter());
    result.fold(
      (l) => emit(state.copyWith(
        reviewsState: RequestStates.error,
        viewReviewMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          reviewsState: RequestStates.loaded,
          reviews: r,
        ),
      ),
    );
  }
  void _deleteReview(DeleteReviewDataEvent event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(
      deleteReviewState: RequestStates.loading,
    ));
    final result = await _deleteReviewUseCase(event.reviewID);
    result.fold(
      (l) => emit(state.copyWith(
        deleteReviewState: RequestStates.error,
        deleteReviewMessage: l.message.toString(),
      )),
      (r) {
        emit(
        state.copyWith(
          deleteReviewState: RequestStates.loaded,
          deleteReviewMessage: r,
        ),
      );
      },
    );
  }
  void _addReview(AddReviewDataEvent event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(
      addReviewState: RequestStates.loading,
    ));
    final result = await _addReviewUseCase(event.addReviewInputs);
    result.fold(
      (l) => emit(state.copyWith(
        addReviewState: RequestStates.error,
        addReviewMessage: l.message.toString(),
      )),
      (r) {
        emit(
        state.copyWith(
          addReviewState: RequestStates.loaded,
          addReviewMessage: r,
        ),
      );
      },
    );
  }
}
