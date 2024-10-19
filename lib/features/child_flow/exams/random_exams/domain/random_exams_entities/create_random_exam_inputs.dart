part of'../../random_exams.dart';

class CreateRandomExamInputs extends Equatable {
  final int subjectId;
  final int questionsNum;
  const CreateRandomExamInputs({
    this.subjectId = 0,
    this.questionsNum = 0,
  });

  @override
  List<Object?> get props => [subjectId, questionsNum];

  CreateRandomExamInputs copyWith({
    int? subjectId,
    int? questionsNum,
  }) {
    return CreateRandomExamInputs(
      subjectId: subjectId ?? this.subjectId,
      questionsNum: questionsNum ?? this.questionsNum,
    );
  }
}


class AllRandomExamInputs extends Equatable {
  final int subjectId;
  final int? childId;
  const AllRandomExamInputs({
    required this.subjectId ,
    this.childId = 0,
  });

  @override
  List<Object?> get props => [subjectId, childId];

  AllRandomExamInputs copyWith({
    int? subjectId,
    int? childId,
  }) {
    return AllRandomExamInputs(
      subjectId: subjectId ?? this.subjectId,
      childId: childId ?? this.childId,
    );
  }
}