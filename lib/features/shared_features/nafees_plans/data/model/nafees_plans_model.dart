part of '../../nafees_plans.dart';


class NafeesPlansModel extends NafeesPlansEntity {
  const NafeesPlansModel({
    required super.id,
    required super.img,
    required super.price,
    required super.oldPrice,
    required super.description,
    required super.name,
    required super.examsData,
    required super.isSubscribed,
  });

  factory NafeesPlansModel.fromJson(Map<String, dynamic> json) {
    return NafeesPlansModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      price: json['price'],
      oldPrice: json['old_price'],
      description: json['description'],
      isSubscribed: json['is_subscribed'],
      examsData: List<NafeesExamsData>.from(json['exams'].map((x) => NafeesExamsDataModel.fromJson(x))),

    );
  }
}

class NafeesExamsDataModel extends NafeesExamsData {
  const NafeesExamsDataModel({
    required super.name,
    required  super.id,
    required  super.textColor,
    required  super.backgroundColor,
  });

  factory NafeesExamsDataModel.fromJson(Map<String, dynamic> json) {
    return NafeesExamsDataModel(
      name: json['name'],
      id: json['id'],
      textColor: json['color'],
      backgroundColor: json['background'],);
  }
}

class NafeesQuestionAnswersModel extends NafeesQuestionAnswersEntity {
  const NafeesQuestionAnswersModel({
    required  super.id,
    required  super.img,
    required  super.option,
    required  super.isTrue,
    required  super.questionId,
  });

  factory NafeesQuestionAnswersModel.fromJson(Map<String, dynamic> json) {
    return NafeesQuestionAnswersModel(
      id: json['id'],
      img: json['img'],
      option: json['option'],
      isTrue: json['is_true'],
      questionId: json['question_id'],
    );
  }
}


class NafeesQuestionModel extends NafeesQuestionEntity {
  const NafeesQuestionModel({
    required  super.id,
    required  super.img,
    required  super.name,
    required  super.description,
    required  super.category,
    required  super.examId,
    required  super.answers,
    required  super.usePiece,
  });

  factory NafeesQuestionModel.fromJson(Map<String, dynamic> json) {
    return NafeesQuestionModel(
      id: json['id'],
      img: json['img'],
      name: json['name'],
      description: json['description'],
      category: json['category']??"",
      examId: json['exam_id'],
      usePiece: json['use_piece']=="0"?false:true,
      answers: List<NafeesQuestionAnswersEntity>.from(json['options'].map((x) => NafeesQuestionAnswersModel.fromJson(x))),
    );
  }
}


class NafeesExamResultsModel extends NafeesExamResults {
  const NafeesExamResultsModel({
    required  super.id,
    required  super.date,
    required  super.trueAnswersCount,
    required  super.falseAnswersCount,
  });

  factory NafeesExamResultsModel.fromJson(Map<String, dynamic> json) {
    return NafeesExamResultsModel(
      id: json['id'],
      date: json['created_at'],
      trueAnswersCount: json['true_answers_count'],
      falseAnswersCount: json['false_answers_count'],
    );
  }
}


class NafeesFullExamModel extends NafeesFullExamEntity {
  const NafeesFullExamModel({
    required super.id,
    required super.name,
    required super.childId,
    required super.createdAt,
    required super.backgroundColor,
    required super.duration,
    required super.piece,
    required super.questionsCount,
    required super.isSubscribe,
    required super.textColor,
    required super.nafeesExamResults,
    required super.nafeesQuestionEntity,
  });

  factory NafeesFullExamModel.fromJson(Map<String, dynamic> json) {
    return NafeesFullExamModel(
        id : json['id'],
        duration : json['duration'],
        name : json['name'],
        textColor : json['color'],
        backgroundColor : json['background'],
        piece : json['piece'],
        createdAt : json['created_at'],
        questionsCount : json['questions_count']??0,
        isSubscribe : json['is_subscribe'],
        childId : json['child_id']??0,
        nafeesExamResults :json['models_answers'] == null ?[]: List<NafeesExamResults>.from(json['models_answers'].map((x) => NafeesExamResultsModel.fromJson(x))),
        nafeesQuestionEntity : json['models_answers'] == null ?[]: List<NafeesQuestionEntity>.from(json['questions'].map((x) => NafeesQuestionModel.fromJson(x))),
    );
  }
}


class NafeesAnswersForModelAnswersModel extends NafeesAnswersForModelAnswersEntity {
  const NafeesAnswersForModelAnswersModel({
    required super.id,
    required super.successId,
    required super.isTrue,
    required super.nafeesQuestionEntity,
  });

  factory NafeesAnswersForModelAnswersModel.fromJson(Map<String, dynamic> json) {
    return NafeesAnswersForModelAnswersModel(
        id : json['id'],
        successId : json['option_id'],
        isTrue : json['is_true'],
        nafeesQuestionEntity : NafeesQuestionModel.fromJson(json['question']),
    );
  }
}


class NafeesModelAnswersModel extends NafeesModelAnswersEntity {
  const NafeesModelAnswersModel({
    required super.id,
    required super.childId,
    required super.answers,
  });

  factory NafeesModelAnswersModel.fromJson(Map<String, dynamic> json) {
    return NafeesModelAnswersModel(
      id : json['id'],
      childId : json['child_id'],
      answers : List<NafeesAnswersForModelAnswersEntity>.from(json['answers'].map((x) => NafeesAnswersForModelAnswersModel.fromJson(x))),
    );
  }
}
