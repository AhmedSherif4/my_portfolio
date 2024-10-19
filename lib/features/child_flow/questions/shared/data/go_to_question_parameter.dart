import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

class ParameterGoToQuestions extends Equatable {
  final int systemId;
  final int subjectId;
  final int stageId;
  final int classRoomId;
  final int termId;
  final int pathId;
  final bool isFromNafees;
  final SubjectType subjectType;


  final bool isGeneralQuestion;

  //for general questions
  final int levelId;
  final int groupId;

  //for Lessons questions
  final int lessonId;

  final bool isChild;

  final int userId;

  const ParameterGoToQuestions({
    this.groupId = 0,
    this.lessonId = 0,
    this.levelId = 0,
    this.subjectId = 0,
    this.isGeneralQuestion = false,
    required this.stageId,
    required this.classRoomId,
    required this.termId,
    this.isChild = true,
    this.userId = 0,
    this.systemId = 0,
    this.pathId = 0,
    this.isFromNafees = false,
    this.subjectType = SubjectType.public
  });

  ParameterGoToQuestions copyWith({
    int? subjectId,
    int? stageId,
    int? classRoomId,
    int? termId,
    int? levelId,
    int? groupId,
    int? lessonId,
    bool? isGeneralQuestion,
    bool? isChild,
    int? userId,
    int? systemId,
    int? pathId,
    bool? isFromNafees,
    SubjectType? subjectType,
  }) {
    return ParameterGoToQuestions(
      subjectId: subjectId ?? this.subjectId,
      stageId: stageId ?? this.stageId,
      classRoomId: classRoomId ?? this.classRoomId,
      termId: termId ?? this.termId,
      levelId: levelId ?? this.levelId,
      groupId: groupId ?? this.groupId,
      lessonId: lessonId ?? this.lessonId,
      isGeneralQuestion: isGeneralQuestion ?? this.isGeneralQuestion,
      isChild: isChild ?? this.isChild,
      userId: userId ?? this.userId,
      systemId: systemId?? this.systemId,
      pathId: pathId?? this.pathId,
      isFromNafees: isFromNafees?? this.isFromNafees,
      subjectType:  subjectType ?? this.subjectType ,
    );
  }

  @override
  List<Object> get props => [
        subjectId,
        stageId,
        classRoomId,
        termId,
        isGeneralQuestion,
        levelId,
        groupId,
        lessonId,
        isChild,
        userId,
    systemId,
    pathId,
    isFromNafees,
    subjectType
      ];
}




class ParameterUpdatePoints extends Equatable {
  final int index;
  final int? unitIndex;
  final int subjectId;

  const ParameterUpdatePoints({
    required this.index,
    required this.subjectId,
    this.unitIndex
  });

  ParameterUpdatePoints copyWith({
    int? index,
    int? subjectId,
    int? unitIndex,
  }){
    return ParameterUpdatePoints(
      index: index ?? this.index,
      subjectId: subjectId ?? this.subjectId,
      unitIndex: unitIndex ?? this.unitIndex
    );
  }

  @override
  List<Object> get props => [
        index,
        subjectId,
      ];
}
