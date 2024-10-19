import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/features/child_flow/home/domain/home_entities/subjects_entity.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_questions_data.dart';

import '../random_exams/random_exams.dart';

class DataToGoExams extends Equatable {
  final List<SubjectsEntity> subjects;
  final UserEntity user;
  final bool isPrimary;
  final int? termId;
  final int? pathId;
  final int? examId;
  final RandomExamEntityOutputs? data;
  final DataToGoQuestions? dataToGoQuestions;
  final bool? fromSubscription;
  final bool? isParent;

  const DataToGoExams({
    required this.subjects,
    required this.user,
    required this.isPrimary,
    this.termId,
    this.pathId,
    this.examId,
    this.data,
    this.dataToGoQuestions,
    this.fromSubscription,
    this.isParent,
  });

  DataToGoExams copyWith({
    List<SubjectsEntity>? subjects,
    UserEntity? user,
    bool? isPrimary,
    int? termId,
    int? pathId,
    int? examId,
    RandomExamEntityOutputs? data,
    DataToGoQuestions? dataToGoQuestions,
    bool? fromSubscription,
    bool? isParent,
  }) {
    return DataToGoExams(
      subjects: subjects ?? this.subjects,
      user: user ?? this.user,
      isPrimary: isPrimary ?? this.isPrimary,
      termId: termId ?? this.termId,
      pathId: pathId ?? this.pathId,
      examId: examId ?? this.examId,
      data: data ?? this.data,
      dataToGoQuestions: dataToGoQuestions ?? this.dataToGoQuestions,
      fromSubscription: fromSubscription ?? this.fromSubscription,
      isParent: isParent ?? this.isParent,
    );
  }

  @override
  List<Object?> get props => [
        subjects,
        user,
        isPrimary,
        termId,
        pathId,
        examId,
        data,
        fromSubscription,
        isParent,
        dataToGoQuestions
      ];
}
