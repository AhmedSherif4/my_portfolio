part of '../../simulated_plans.dart';


class SimulatedCategoriesModel extends SimulatedCategoriesEntity {
  const SimulatedCategoriesModel({
    required super.id,
    required super.img,
    required super.name,
    required super.categories,
  });

  factory SimulatedCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SimulatedCategoriesModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      categories: List<SimulatedPlansEntity>.from(json['categories'].map((x) => SimulatedPlansModel.fromJson(x))),

    );
  }
}


class SimulatedPlansModel extends SimulatedPlansEntity {
  const SimulatedPlansModel({
    required super.id,
    required super.img,
    required super.price,
    required super.oldPrice,
    required super.description,
    required super.name,
    required super.examsData,
    required super.isSubscribed,
  });

  factory SimulatedPlansModel.fromJson(Map<String, dynamic> json) {
    return SimulatedPlansModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      price: json['price'],
      oldPrice: json['old_price'],
      description: json['description'],
      isSubscribed: json['is_subscribed'],
      examsData: List<SimulatedExamsData>.from(json['exams'].map((x) => SimulatedExamsDataModel.fromJson(x))),

    );
  }
}

class SimulatedExamsDataModel extends SimulatedExamsData {
  const SimulatedExamsDataModel({
    required super.name,
    required  super.id,
    required  super.textColor,
    required  super.backgroundColor,
  });

  factory SimulatedExamsDataModel.fromJson(Map<String, dynamic> json) {
    return SimulatedExamsDataModel(
      name: json['name'],
      id: json['id'],
      textColor: json['color'],
      backgroundColor: json['background'],);
  }
}

class SimulatedQuestionAnswersModel extends SimulatedQuestionAnswersEntity {
  const SimulatedQuestionAnswersModel({
    required  super.id,
    required  super.img,
    required  super.option,
    required  super.isTrue,
    required  super.questionId,
  });

  factory SimulatedQuestionAnswersModel.fromJson(Map<String, dynamic> json) {
    return SimulatedQuestionAnswersModel(
      id: json['id'],
      img: json['img'],
      option: json['option'],
      isTrue: json['is_true'],
      questionId: json['question_id'],
    );
  }
}


class SimulatedQuestionModel extends SimulatedQuestionEntity {
  const SimulatedQuestionModel({
    required  super.id,
    required  super.img,
    required  super.name,
    required  super.description,
    required  super.category,
    required  super.examId,
    required  super.answers,
    required  super.usePiece,
  });

  factory SimulatedQuestionModel.fromJson(Map<String, dynamic> json) {
    return SimulatedQuestionModel(
      id: json['id'],
      img: json['img'],
      name: json['name'],
      description: json['description'],
      category: json['category']??"",
      examId: json['exam_id'],
      usePiece: json['use_piece']=="0"?false:true,
      answers: List<SimulatedQuestionAnswersEntity>.from(json['options'].map((x) => SimulatedQuestionAnswersModel.fromJson(x))),
    );
  }
}


class SimulatedExamResultsModel extends SimulatedExamResults {
  const SimulatedExamResultsModel({
    required  super.id,
    required  super.date,
    required  super.trueAnswersCount,
    required  super.falseAnswersCount,
  });

  factory SimulatedExamResultsModel.fromJson(Map<String, dynamic> json) {
    return SimulatedExamResultsModel(
      id: json['id'],
      date: json['created_at'],
      trueAnswersCount: json['true_answers_count'],
      falseAnswersCount: json['false_answers_count'],
    );
  }
}


class SimulatedFullExamModel extends SimulatedFullExamEntity {
  const SimulatedFullExamModel({
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
    required super.simulatedExamResults,
    required super.simulatedQuestionEntity,
  });

  factory SimulatedFullExamModel.fromJson(Map<String, dynamic> json) {
    return SimulatedFullExamModel(
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
        simulatedExamResults :json['models_answers'] == null ?[]: List<SimulatedExamResults>.from(json['models_answers'].map((x) => SimulatedExamResultsModel.fromJson(x))),
        simulatedQuestionEntity : json['models_answers'] == null ?[]: List<SimulatedQuestionEntity>.from(json['questions'].map((x) => SimulatedQuestionModel.fromJson(x))),
    );
  }
}


class SimulatedAnswersForModelAnswersModel extends SimulatedAnswersForModelAnswersEntity {
  const SimulatedAnswersForModelAnswersModel({
    required super.id,
    required super.optionId,
    required super.isTrue,
    required super.simulatedQuestionEntity,
  });

  factory SimulatedAnswersForModelAnswersModel.fromJson(Map<String, dynamic> json) {
    return SimulatedAnswersForModelAnswersModel(
        id : json['id'],
        optionId : json['option_id'],
        isTrue : json['is_true'],
        simulatedQuestionEntity : SimulatedQuestionModel.fromJson(json['question']),
    );
  }
}


class SimulatedModelAnswersModel extends SimulatedModelAnswersEntity {
  const SimulatedModelAnswersModel({
    required super.id,
    required super.childId,
    required super.answers,
  });

  factory SimulatedModelAnswersModel.fromJson(Map<String, dynamic> json) {
    return SimulatedModelAnswersModel(
      id : json['id'],
      childId : json['child_id'],
      answers : List<SimulatedAnswersForModelAnswersEntity>.from(json['answers'].map((x) => SimulatedAnswersForModelAnswersModel.fromJson(x))),
    );
  }
}
