import 'package:equatable/equatable.dart';

class AllSubscriptionModel extends Equatable {
  final int id;
  final String classroomName;
  final List<Term> allTerms;

  const AllSubscriptionModel({
    required this.id,
    required this.classroomName,
    required this.allTerms,
  });

  factory AllSubscriptionModel.fromJson(Map<String, dynamic> json) {
    List<Term> terms = (json['terms'] as List<dynamic>)
        .map((termJson) => Term.fromJson(termJson))
        .toList();

    return AllSubscriptionModel(
      id: json['id'] as int,
      classroomName: json['name'] as String,
      allTerms: terms,
    );
  }

  @override
  List<Object?> get props => [allTerms, classroomName, id];
}

class Term extends Equatable {
  final int stageId;
  final int classroomId;
  final int termId;
  final int pathId;
  final String name;
  final bool isSubscribe;

  const Term({
    required this.stageId,
    required this.classroomId,
    required this.termId,
    required this.pathId,
    required this.name,
    required this.isSubscribe,
  });

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      termId: json['id'] as int,
      pathId: json['path_id'] == null ? 0 : json['path_id'] as int,
      stageId: json['stage_id'] as int,
      classroomId: json['classroom_id'] as int,
      name: json['name'] as String,
      isSubscribe: json['subscrib'] as bool,
    );
  }

  @override
  List<Object?> get props => [stageId, termId, classroomId, name, isSubscribe, pathId];
}
