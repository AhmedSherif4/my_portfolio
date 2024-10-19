part of '../../simulated_plans.dart';


abstract class SimulatedBaseRepository {
  Future<Either<Failure, List<SimulatedCategoriesEntity>>> getSimulatedPlans({required int childId});

  Future<Either<Failure, SimulatedFullExamEntity>> getSimulatedExams({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs});

  Future<Either<Failure, SimulatedModelAnswersEntity>> getSimulatedModelAnswers({required int modelId});

  Future<Either<Failure, String>> submitExamAnswer({required SimulatedExamQuestionsAnswersInputs simulatedExamQuestionsAnswersInputs});
}


class SimulatedExamQuestionsAnswersInputs  {
  int? examId;
  int? childId;
  List<SimulatedExamQuestionsAndAnswersIdsInputs>? questions;

  SimulatedExamQuestionsAnswersInputs({
    required this.examId,
    required this.childId,
    this.questions
  });
  SimulatedExamQuestionsAnswersInputs.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    childId = json['child_id'];
    if (json['questions'] != null) {
      questions = <SimulatedExamQuestionsAndAnswersIdsInputs>[];
      json['questions'].forEach((v) {
        questions!.add(SimulatedExamQuestionsAndAnswersIdsInputs.fromJson(v));
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

class SimulatedExamQuestionsAndAnswersIdsInputs  {
  String? questionId;
  String? answerId;
  bool isSelected = false;

  SimulatedExamQuestionsAndAnswersIdsInputs({this.questionId, this.answerId});

  SimulatedExamQuestionsAndAnswersIdsInputs.fromJson(Map<String, dynamic> json) {
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