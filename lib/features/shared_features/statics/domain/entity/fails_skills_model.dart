part of '../../statics.dart';





class FailsSkillsForLessonsModel extends Equatable {
  final String skills;
  final List<QuestionEntity> questions;


  const FailsSkillsForLessonsModel({
    required this.skills,
    required this.questions,
  });

  factory FailsSkillsForLessonsModel.fromJson(Map<String, dynamic> json) {
    return FailsSkillsForLessonsModel(
      skills: AppReference.userIsChild()? json['skill'] ?? '' : json['skills'] ?? '',
      questions:
      List<QuestionEntity>.from( json['questions'].map((x) => QuestionModel.fromMap(x))),
    );
  }

  @override
  List<Object> get props => [
   skills,
    questions
  ];
}
class FailQuestionsModel extends Equatable {
  final int questionId;
  final String questionText;


  const FailQuestionsModel({
    required this.questionId,
    required this.questionText,
  });



  factory FailQuestionsModel.fromJson(Map<String, dynamic> json) {
    return FailQuestionsModel(
      questionId: json['id'] ?? 0,
      questionText: json['ques_text'] ?? '',
    );
  }


  @override
  List<Object> get props => [
    questionId,
    questionText
  ];
}

