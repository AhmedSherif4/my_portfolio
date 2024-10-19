import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'result_exam_entity.g.dart';

@HiveType(typeId: 6)
class ResultExamEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String file;
  @HiveField(2)
  final int degree;
  @HiveField(3)
  final String isMark;
  @HiveField(4)
  final String? childLevel;
  @HiveField(5)
  final int examId;
  @HiveField(6)
  final int childId;
  @HiveField(7)
  final bool reupload;
  @HiveField(8)
  final List<String>? description;

  const ResultExamEntity({
    required this.id,
    required this.file,
    required this.degree,
    required this.isMark,
    required this.childLevel,
    required this.examId,
    required this.childId,
    this.reupload = true,
    required this.description,
  });

  @override
  List<Object?> get props {
    return [
      id,
      file,
      degree,
      isMark,
      childLevel,
      examId,
      childId,
      reupload,
      description,
    ];
  }

  ResultExamEntity copyWith({
    int? id,
    String? file,
    int? degree,
    String? isMark,
    String? childLevel,
    int? examId,
    int? childId,
    bool? reupload,
    List<String>? description,
  }) {
    return ResultExamEntity(
      id: id ?? this.id,
      file: file ?? this.file,
      degree: degree ?? this.degree,
      isMark: isMark ?? this.isMark,
      childLevel: childLevel ?? this.childLevel,
      examId: examId ?? this.examId,
      childId: childId ?? this.childId,
      reupload: reupload ?? this.reupload,
      description: description ?? this.description,
    );
  }
}
