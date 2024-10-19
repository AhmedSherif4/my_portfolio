part of '../../simulated_plans.dart';


class SimulatedCategoriesEntity extends Equatable {
  final int id;
  final String name;
  final String? img;
  final List<SimulatedPlansEntity> categories;

  const SimulatedCategoriesEntity({
    required this.name,
    required this.id,
    required this.img,
    required this.categories,
  });

  @override
  List<Object?> get props => [
    name,
    id,
    img,
    categories,
  ];
}


class SimulatedPlansEntity extends Equatable {
  final int id;
  final int price;
  final int oldPrice;
  final String name;
  final String description;
  final bool isSubscribed;
  final String? img;
  final List<SimulatedExamsData> examsData;

  const SimulatedPlansEntity({
    required this.name,
    required this.id,
    required this.img,
    required this.isSubscribed,
    required this.description,
    required this.examsData,
    required this.price,
    required this.oldPrice,
  });

  @override
  List<Object?> get props => [
    name,
    id,
    img,
    description,
    examsData,
    isSubscribed,
    price,
    oldPrice
  ];
}


class SimulatedExamsData extends Equatable {
  final int id;
  final String name;
  final String textColor;
  final String backgroundColor;

  const SimulatedExamsData({
    required this.name,
    required this.id,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  List<Object?> get props => [
    name,
    id,
    textColor,
    backgroundColor,
  ];
}


class SimulatedFullExamEntity extends Equatable {
  final int id;
  final int duration;
  final String name;
  final String textColor;
  final String backgroundColor;
  final String piece;
  final String createdAt;
  final int questionsCount;
  final bool isSubscribe;
  final int childId;
  final List<SimulatedExamResults> simulatedExamResults;
  final List<SimulatedQuestionEntity> simulatedQuestionEntity;

  const SimulatedFullExamEntity({
    required this.id,
    required this.duration,
    required this.name,
    required this.textColor,
    required this.backgroundColor,
    required this.piece,
    required this.createdAt,
    required this.questionsCount,
    required this.isSubscribe,
    required this.childId,
    required this.simulatedExamResults,
    required this.simulatedQuestionEntity,
  });

  @override
  List<Object?> get props => [
    simulatedExamResults,
    simulatedQuestionEntity,
    id,
    duration,
    name,
    textColor,
    backgroundColor,
    piece,
    createdAt,
    questionsCount,
    isSubscribe,
    childId,
  ];
}


class SimulatedExamResults extends Equatable {
  final int id;
  final String date;
  final int trueAnswersCount;
  final int falseAnswersCount;
  const SimulatedExamResults({
    required this.id,
    required this.date,
    required this.trueAnswersCount,
    required this.falseAnswersCount,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    trueAnswersCount,
    falseAnswersCount
  ];
}


class SimulatedQuestionEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool usePiece;
  final String? img;
  final String? category;
  final int examId;
  final List<SimulatedQuestionAnswersEntity> answers;

  const SimulatedQuestionEntity({
    required this.name,
    required this.id,
    required this.description,
    required this.img,
    required this.category,
    required this.examId,
    required this.answers,
    required this.usePiece,
  });

  @override
  List<Object?> get props => [
    name,
    id,
    description,
    img,
    category,
    examId,
    answers,
  ];
}

class SimulatedQuestionAnswersEntity extends Equatable {
  final int id;
  final String? option;
  final String isTrue;
  final String? img;
  final int  questionId;
  const SimulatedQuestionAnswersEntity({
    required this.id,
    required this.img,
    required this.option,
    required this.isTrue,
    required this.questionId,
  });

  @override
  List<Object?> get props => [
    id,
    img,
    option,
    isTrue,
    questionId,
  ];
}

class SimulatedModelAnswersEntity extends Equatable {
  final int id;
  final int childId;
  final List<SimulatedAnswersForModelAnswersEntity>? answers;
  const SimulatedModelAnswersEntity({
    required this.childId,
    required this.id,
    required this.answers,
  });

  @override
  List<Object?> get props => [
    id,
   childId,
   answers,
  ];
}


class SimulatedAnswersForModelAnswersEntity extends Equatable {
  final int id;
  final int optionId;
  final String isTrue;
  final SimulatedQuestionEntity simulatedQuestionEntity;
  const SimulatedAnswersForModelAnswersEntity({
    required this.isTrue,
    required this.optionId,
    required this.id,
    required this.simulatedQuestionEntity,

  });

  @override
  List<Object?> get props => [
    id,
    simulatedQuestionEntity,
    isTrue,
    optionId,
  ];
}
