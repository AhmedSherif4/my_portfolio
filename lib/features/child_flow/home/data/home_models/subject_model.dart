import '../../domain/home_entities/subjects_entity.dart';

class SubjectModel extends SubjectsEntity {
  const SubjectModel({
    required super.subjectName,
    required super.subjectImg,
    required super.subjectId,
    required super.itemColor,
    required super.isHaveUnit,
    required super.price,
    required super.oldPrice,
    required super.classroomId,
    required super.termId,
    required super.stageId,
     super.pathId,
  });

  factory SubjectModel.fromMap(Map<String, dynamic> json, bool isNotSub) {
    return isNotSub
        ? SubjectModel(
            subjectName: json["name"] as String,
            subjectImg: json["img"] ?? '',
            subjectId: json["id"] as int,
            itemColor: json["color"] ?? '',
            isHaveUnit: json["is_unit"] as bool,
            price: json["price"] ?? 0,
            classroomId: json["classroom_id"] as int,
            termId: json["term_id"] as int,
            stageId: json["stage_id"] as int,
            oldPrice: json["old_price"] ?? 0,
            pathId: json["path_id"] ??0,
    )
        : SubjectModel(
            subjectName: json['subject']["name"] as String,
            subjectImg: json['subject']["img"] ?? '',
            subjectId: json["subject_id"] as int,
            itemColor: json['subject']["color"] ?? '',
            isHaveUnit: json['subject']["is_unit"] as bool,
            price: json['subject']["price"] as int,
            oldPrice: json['subject']["old_price"] ?? 0,
            classroomId: json['subject']["classroom_id"] as int,
            termId: json['subject']["term_id"] as int,
            stageId: json['subject']["stage_id"] as int,
            pathId: json['subject']["path_id"] ??0,
          );
  }
}
