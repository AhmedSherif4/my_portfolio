import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'subjects_entity.g.dart';

@HiveType(typeId: 2)
class SubjectsEntity extends Equatable {
  @HiveField(0)
  final int subjectId;
  @HiveField(1)
  final String subjectName;
  @HiveField(2)
  final String subjectImg;
  @HiveField(3)
  final String itemColor;
  @HiveField(4)
  final int price;
  @HiveField(5)
  final int classroomId;
  @HiveField(6)
  final int termId;
  @HiveField(7)
  final int stageId;
  @HiveField(8)
  final bool isHaveUnit;
  @HiveField(9)
  final int oldPrice;
  @HiveField(10)
  final int? pathId;

  const SubjectsEntity({
    required this.isHaveUnit,
    required this.itemColor,
    required this.subjectName,
    required this.subjectImg,
    required this.subjectId,
    required this.price,
    required this.classroomId,
    required this.termId,
    required this.stageId,
    required this.oldPrice,
     this.pathId,
  });

  @override
  List<Object> get props => [
        subjectId,
        subjectName,
        subjectImg,
        itemColor,
        isHaveUnit,
        price,
        classroomId,
        termId,
        stageId,
        oldPrice,
      ];
}
