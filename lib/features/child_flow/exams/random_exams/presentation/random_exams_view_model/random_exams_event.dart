part of '../../random_exams.dart';

abstract class RandomExamsEvent extends Equatable {
  const RandomExamsEvent();
}

class GetAllRandomExamsOfThatSubject extends RandomExamsEvent {
  final AllRandomExamInputs allRandomExamInputs;
  final int selectedIndex;
  const GetAllRandomExamsOfThatSubject(
      {required this.allRandomExamInputs, required this.selectedIndex});
  @override
  List<Object?> get props => [allRandomExamInputs, selectedIndex];
}

class CreateRandomExamsOfThatSubject extends RandomExamsEvent {
  final CreateRandomExamInputs createRandomExamInputs;
  const CreateRandomExamsOfThatSubject({required this.createRandomExamInputs});
  @override
  List<Object?> get props => [createRandomExamInputs];
}

class RepeatRandomExamsOfThatSubject extends RandomExamsEvent {
  final int examId;
  const RepeatRandomExamsOfThatSubject({required this.examId});
  @override
  List<Object?> get props => [];
}

class AddRandomExamsQuestionsAndAnswers extends RandomExamsEvent {
  final RandomExamQuestionsAnswersInputs randomExamQuestionsAnswersInputs;
  const AddRandomExamsQuestionsAndAnswers(
      {required this.randomExamQuestionsAnswersInputs});
  @override
  List<Object?> get props => [];
}

class UpdateRandomExamsQuestionsAnswersEvent extends RandomExamsEvent {
  final String questionId;
  final String childAnswer;
  final int selectedAnswer;

  const UpdateRandomExamsQuestionsAnswersEvent({
    required this.questionId,
    required this.childAnswer,
    required this.selectedAnswer,
  });
  @override
  List<Object?> get props => [
        questionId,
        childAnswer,
        selectedAnswer,
      ];
}
