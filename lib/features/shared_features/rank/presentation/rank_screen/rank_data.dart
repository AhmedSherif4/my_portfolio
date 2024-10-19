import 'package:equatable/equatable.dart';

import '../../rank.dart';

class RankData extends Equatable {
  final int systemId;
  final int stageId;
  final int classroomId;
  final int? subjectId;
  final int termId;
  final int? pathId;
  final int childId;
  final RankType? rankType;
  final String? className;

  const RankData({
    required this.stageId,
    required this.systemId,
    required this.classroomId,
    this.pathId,
    this.subjectId,
    required this.termId,
    required this.childId,
    this.rankType,
    this.className,
  });

  @override
  List<Object?> get props => [
        stageId,
        classroomId,
        subjectId,
        termId,
        childId,
        rankType,
        pathId,
        systemId,
    className
      ];

  RankData copyWith({
    int? stageId,
    int? classroomId,
    int? subjectId,
    int? termId,
    int? childId,
    int? systemId,
    int? pathId,
    RankType? rankType,
    String? className,
  }) {
    return RankData(
      stageId: stageId ?? this.stageId,
      classroomId: classroomId ?? this.classroomId,
      subjectId: subjectId ?? this.subjectId,
      termId: termId ?? this.termId,
      rankType: rankType ?? this.rankType,
      childId: childId ?? this.childId,
      systemId: systemId ?? this.systemId,
      pathId: pathId ?? this.pathId,
      className: className ?? this.className,
    );
  }
}
