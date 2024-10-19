import 'package:equatable/equatable.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/domain/lessons_entities/lessons_entity.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/entity/levels_group_entity.dart';

import '../../../home/domain/home_entities/subjects_entity.dart';

class DataToGoQuestions extends Equatable {
  final int subjectId;
  final bool isPrimary;
  final bool isGeneralQuestions;
  final int stageId;
  final int classRoomId;
  final int termId;
  final int systemId;
  final int pathId;
  final bool isFromNafees;

  //for lesson screen
  final String subjectName;
  final String imgUrl;
  final bool notHaveImage;
  final bool subjectsHaveUnits;
  final int lessonId;

  //Challenge
  final List<SubjectsEntity> subjects;

  //for general questions
  final int levelId;
  final String levelName;
  final String levelColor;
  final String levelImage;
  final bool levelImageNotFound;
  final int groupId;

  final LevelAndCollectionEntity? collectionEntity;
  final int? itemIndex;
  final int? unitIndex;
  final bool subjectHaveUnits;
  final LessonEntity? lessonEntity;




  const DataToGoQuestions({
    this.collectionEntity,
    this.isGeneralQuestions = false,
    required this.imgUrl,
    required this.notHaveImage,
    required this.subjectName,
    required this.stageId,
    required this.classRoomId,
    required this.termId,
    required this.subjectId,
    required this.isPrimary,
    this.lessonId = 0,
    this.levelId = 0,
    this.groupId = 0,
    this.subjectsHaveUnits = false,
    this.lessonEntity,
    this.itemIndex,
    this.unitIndex,
    this.subjectHaveUnits = false,
    this.levelImageNotFound = true,
    this.levelName = '',
    this.levelColor = '',
    this.levelImage = '',
    this.subjects = const [],
    required this.systemId,
    this.pathId = 0,
    this.isFromNafees = false,
  });






  DataToGoQuestions copyWith({
    int? subjectId,
    bool? isPrimary,
    int? stageId,
    int? classRoomId,
    int? termId,
    int? lessonId,
    int? levelId,
    int? collectionId,
    String? subjectName,
    String? imgUrl,
    bool? notHaveImage,
    bool? isGeneralQuestions,
    bool? subjectsHaveUnits,
    LevelAndCollectionEntity? collectionEntity,
    LessonEntity? lessonEntity,
    int? itemIndex,
    int? unitIndex,
    bool? subjectHaveUnits,
    bool? levelImageNotFound,
    String? levelName,
    String? levelColor,
    String? levelImage,
    List<SubjectsEntity>? subjects,
    int? systemId,
    int? pathId,
    bool? isFromNafees,
  }) {
    return DataToGoQuestions(
      subjectId: subjectId ?? this.subjectId,
      isPrimary: isPrimary ?? this.isPrimary,
      stageId: stageId ?? this.stageId,
      classRoomId: classRoomId ?? this.classRoomId,
      termId: termId ?? this.termId,
      lessonId: lessonId ?? this.lessonId,
      levelId: levelId ?? this.levelId,
      groupId: collectionId ?? groupId,
      subjectName: subjectName ?? this.subjectName,
      imgUrl: imgUrl ?? this.imgUrl,
      notHaveImage: notHaveImage ?? this.notHaveImage,
      isGeneralQuestions: isGeneralQuestions ?? this.isGeneralQuestions,
      subjectsHaveUnits: subjectsHaveUnits ?? this.subjectsHaveUnits,
      collectionEntity: collectionEntity ?? this.collectionEntity,
      lessonEntity: lessonEntity ?? this.lessonEntity,
      itemIndex: itemIndex ?? this.itemIndex,
      unitIndex: unitIndex ?? this.unitIndex,
      subjectHaveUnits: subjectHaveUnits ?? this.subjectsHaveUnits,
      levelColor: levelColor ?? this.levelColor,
      levelName: levelName ?? this.levelName,
      levelImage: levelImage?? this.levelImage,
      subjects: subjects ?? this.subjects,
      levelImageNotFound: levelImageNotFound?? this.levelImageNotFound,
      systemId: systemId?? this.systemId,
      pathId: pathId?? this.pathId,
      isFromNafees: isFromNafees?? this.isFromNafees,
    );
  }

  @override
  List<Object?> get props => [
        subjectId,
        isPrimary,
        isGeneralQuestions,
        stageId,
        classRoomId,
        termId,
        subjectName,
        imgUrl,
        notHaveImage,
    levelImageNotFound,
        subjectsHaveUnits,
        lessonId,
        subjects,
        levelId,
        levelName,
    levelImage,
        levelColor,
        groupId,
        collectionEntity,
        itemIndex,
        subjectHaveUnits,
        lessonEntity,
    systemId,
    pathId,
    isFromNafees,
      ];
}
