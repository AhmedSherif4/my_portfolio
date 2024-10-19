part of '../../child_common_questions.dart';

class ChildCommonQuestionsState extends Equatable {
  final RequestStates getAllQuestionsState;
  final List<CommonQuestionEntity> allQuestions;
  final String getAllQuestionMessage;

  const ChildCommonQuestionsState({
    this.getAllQuestionsState = RequestStates.initial,
    this.allQuestions = const [],
    this.getAllQuestionMessage = '',
  });

  ChildCommonQuestionsState copyWith({
    RequestStates? getAllQuestionsState,
    List<CommonQuestionEntity>? allQuestions,
    String? getAllQuestionMessage,
  }) {
    return ChildCommonQuestionsState(
      allQuestions: allQuestions ?? this.allQuestions,
      getAllQuestionMessage:
          getAllQuestionMessage ?? this.getAllQuestionMessage,
      getAllQuestionsState: getAllQuestionsState ?? this.getAllQuestionsState,
    );
  }

  @override
  List<Object> get props => [
        getAllQuestionsState,
        allQuestions,
        getAllQuestionMessage,
      ];
}
