import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/domain/exams_entities/result_exam_entity.dart';

part 'exam_entity.g.dart';

@HiveType(typeId: 5)
class ExamEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String file;
  @HiveField(3)
  final int degree;
  @HiveField(4)
  final int stageId;
  @HiveField(5)
  final int classroomId;
  @HiveField(6)
  final int termId;
  @HiveField(7)
  final int subjectId;
  @HiveField(8)
  final ResultExamEntity result;
  @HiveField(9)
  final int systemId;
  @HiveField(10)
  final int? pathId;


  const ExamEntity({
    required this.id,
    required this.name,
    required this.file,
    required this.degree,
    required this.stageId,
    required this.classroomId,
    required this.termId,
    required this.subjectId,
    required this.result,
    required this.systemId,
    this.pathId,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      file,
      degree,
      stageId,
      classroomId,
      termId,
      subjectId,
      result,
      systemId,
      pathId,
    ];
  }

  ExamEntity copyWith({
    int? id,
    String? name,
    String? file,
    int? degree,
    int? stageId,
    int? classroomId,
    int? termId,
    int? subjectId,
    ResultExamEntity? result,
    int? systemId,
    int? pathId,
  }) {
    return ExamEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      file: file ?? this.file,
      degree: degree ?? this.degree,
      stageId: stageId ?? this.stageId,
      classroomId: classroomId ?? this.classroomId,
      termId: termId ?? this.termId,
      subjectId: subjectId ?? this.subjectId,
      result: result ?? this.result,
      systemId: systemId?? this.systemId,
      pathId: pathId?? this.pathId,
    );
  }
}
