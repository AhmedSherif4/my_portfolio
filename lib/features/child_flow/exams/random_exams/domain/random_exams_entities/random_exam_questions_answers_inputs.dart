part of'../../random_exams.dart';

class RandomExamQuestionsAnswersInputs  {
   String? examId;
   List<RandomExamsQuestions>? questions;

   RandomExamQuestionsAnswersInputs({
    required this.examId,
    required this.questions
  });
   RandomExamQuestionsAnswersInputs.fromJson(Map<String, dynamic> json) {
     examId = json['exam_id'];
     if (json['questions'] != null) {
       questions = <RandomExamsQuestions>[];
       json['questions'].forEach((v) {
         questions!.add(RandomExamsQuestions.fromJson(v));
       });
     }
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = <String, dynamic>{};
     data['exam_id'] = examId;
     if (questions != null) {
       data['questions'] = questions!.map((v) => v.toJson()).toList();
     }
     return data;
   }

}


class RandomExamsQuestions {
  String? questionId;
  String? childAnswer;
  bool isSelected = false;

  RandomExamsQuestions({this.questionId, this.childAnswer});

  RandomExamsQuestions.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    childAnswer = json['child_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['child_answer'] = childAnswer;
    return data;
  }
}