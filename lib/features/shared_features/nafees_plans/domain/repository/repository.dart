part of '../../nafees_plans.dart';


abstract class NafeesBaseRepository {
  Future<Either<Failure, List<NafeesPlansEntity>>> getNafeesPlans({required int childId});

  Future<Either<Failure, NafeesFullExamEntity>> getNafeesExams({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs});

  Future<Either<Failure, NafeesModelAnswersEntity>> getNafeesModelAnswers({required int modelId});

  Future<Either<Failure, String>> submitExamAnswer({required NafeesExamQuestionsAnswersInputs nafeesExamQuestionsAnswersInputs});
}


class NafeesExamQuestionsAnswersInputs  {
  int? examId;
  int? childId;
  List<NafeesExamQuestionsAndAnswersIdsInputs>? questions;

  NafeesExamQuestionsAnswersInputs({
    required this.examId,
    required this.childId,
    this.questions
  });
  NafeesExamQuestionsAnswersInputs.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    childId = json['child_id'];
    if (json['questions'] != null) {
      questions = <NafeesExamQuestionsAndAnswersIdsInputs>[];
      json['questions'].forEach((v) {
        questions!.add(NafeesExamQuestionsAndAnswersIdsInputs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_id'] = examId;
    data['child_id'] = childId;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class NafeesExamQuestionsAndAnswersIdsInputs  {
  String? questionId;
  String? answerId;
  bool isSelected = false;

  NafeesExamQuestionsAndAnswersIdsInputs({this.questionId, this.answerId});

  NafeesExamQuestionsAndAnswersIdsInputs.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answerId = json['option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['option_id'] = answerId;
    return data;
  }
}