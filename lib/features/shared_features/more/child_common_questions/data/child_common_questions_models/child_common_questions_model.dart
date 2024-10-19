
import '../../domain/child_common_questions_entities/child_common_questions_entity.dart';

class CommonQuestionModel extends CommonQuestionEntity {
  const CommonQuestionModel({
    required super.question,
    required super.answer,
  });

  factory CommonQuestionModel.fromJson(Map<String, dynamic> json) {
    return CommonQuestionModel(
      question: json['question'],
      answer: json['answer'],
    );
  }
}
