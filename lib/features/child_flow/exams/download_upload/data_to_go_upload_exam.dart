import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/domain/exams_entities/exam_entity.dart';

class DataToGoUploadExam extends Equatable {
  final ExamEntity examEntity;
  final int index;
  final bool isPrimary;

  const DataToGoUploadExam({
    required this.examEntity,
    required this.index,
    required this.isPrimary,
  });

  @override
  List<Object?> get props => [
        examEntity,
        index,
        isPrimary,
      ];
}
