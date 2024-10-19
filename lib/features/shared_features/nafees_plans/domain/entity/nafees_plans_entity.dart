part of '../../nafees_plans.dart';




class NafeesPlansEntity extends Equatable {
  final int id;
  final int price;
  final int oldPrice;
  final String name;
  final String description;
  final bool isSubscribed;
  final String? img;
  final List<NafeesExamsData> examsData;

  const NafeesPlansEntity({
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


class NafeesExamsData extends Equatable {
  final int id;
  final String name;
  final String textColor;
  final String backgroundColor;

  const NafeesExamsData({
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


class NafeesFullExamEntity extends Equatable {
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
  final List<NafeesExamResults> nafeesExamResults;
  final List<NafeesQuestionEntity> nafeesQuestionEntity;

  const NafeesFullExamEntity({
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
    required this.nafeesExamResults,
    required this.nafeesQuestionEntity,
  });

  @override
  List<Object?> get props => [
    nafeesExamResults,
    nafeesQuestionEntity,
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


class NafeesExamResults extends Equatable {
  final int id;
  final String date;
  final int trueAnswersCount;
  final int falseAnswersCount;
  const NafeesExamResults({
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


class NafeesQuestionEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool usePiece;
  final String? img;
  final String? category;
  final int examId;
  final List<NafeesQuestionAnswersEntity> answers;

  const NafeesQuestionEntity({
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

class NafeesQuestionAnswersEntity extends Equatable {
  final int id;
  final String? option;
  final String isTrue;
  final String? img;
  final int  questionId;
  const NafeesQuestionAnswersEntity({
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

class NafeesModelAnswersEntity extends Equatable {
  final int id;
  final int childId;
  final List<NafeesAnswersForModelAnswersEntity>? answers;
  const NafeesModelAnswersEntity({
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


class NafeesAnswersForModelAnswersEntity extends Equatable {
  final int id;
  final int successId;
  final String isTrue;
  final NafeesQuestionEntity nafeesQuestionEntity;
  const NafeesAnswersForModelAnswersEntity({
    required this.isTrue,
    required this.id,
    required this.successId,
    required this.nafeesQuestionEntity,

  });

  @override
  List<Object?> get props => [
    id,
    successId,
    nafeesQuestionEntity,
    isTrue,
  ];
}
