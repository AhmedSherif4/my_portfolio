import 'package:equatable/equatable.dart';

class SubjectSubscriptionsEntity extends Equatable {
  final List<TermsForSubjectSubscriptionsEntity> terms;
  final List<SubjectForSubjectSubscriptionsEntity> optionalSubject;

  const SubjectSubscriptionsEntity({
    required this.terms,
    required this.optionalSubject,
  });

  SubjectSubscriptionsEntity copyWith({
    List<TermsForSubjectSubscriptionsEntity>? terms,
    List<SubjectForSubjectSubscriptionsEntity>? optionalSubject,
  }) {
    return SubjectSubscriptionsEntity(
      terms: terms ?? this.terms,
      optionalSubject: optionalSubject ?? this.optionalSubject,
    );
  }

  @override
  List<Object?> get props => [terms, optionalSubject];
}


class TermsForSubjectSubscriptionsEntity extends Equatable {
  final String message;
  final String name;
  final List<SubjectForSubjectSubscriptionsEntity> subjects;


  const TermsForSubjectSubscriptionsEntity({
    required this.message,
    required this.name,
    required this.subjects,
  });

  @override
  List<Object?> get props =>
      [message, subjects,name];
}


class SubjectForSubjectSubscriptionsEntity extends Equatable {
  final String subjectName;
  final int subjectID;
  final int pathID;
  final int termID;
  final int subjectPrice;
  final int subjectOldPrice;
  final bool isSubscribed;
  final bool cart;
  final bool isFree;



  const SubjectForSubjectSubscriptionsEntity({
    required this.subjectName,
    required this.subjectID,
    required this.pathID,
    required this.termID,
    required this.subjectPrice,
    required this.subjectOldPrice,
    required this.isSubscribed,
    required this.cart,
    required this.isFree,
  });

  @override
  List<Object?> get props =>
      [subjectName, subjectID, subjectPrice, subjectOldPrice, isSubscribed, cart,isFree,pathID,termID];
}

class SubjectSubscriptionsInputs extends Equatable {
  final int classRoomId;
  final int? pathId;
  final int? termId;
  final int? childId;
  const SubjectSubscriptionsInputs( {
    required this.classRoomId,
    this.pathId,
    this.childId,
    this.termId,
  });

  @override
  List<Object?> get props => [pathId, classRoomId, childId,termId];

  SubjectSubscriptionsInputs copyWith({
    int? classRoomId,
    int? pathId,
    int? childId,
    int? termId,
  }) {
    return SubjectSubscriptionsInputs(
      pathId: pathId ?? this.pathId,
      classRoomId: classRoomId ?? this.classRoomId,
      childId: childId ?? this.childId,
      termId: termId ?? this.termId,
    );
  }
}


class AddAndDeleteSubjectInputs extends Equatable {
  final int subjectId;
  final int? pathId;
  final int? termId;
  final int? childId;
  const AddAndDeleteSubjectInputs({
    required this.subjectId,
    this.childId,
    this.pathId,
    this.termId,
  });

  @override
  List<Object?> get props => [subjectId, childId, pathId, termId];

  AddAndDeleteSubjectInputs copyWith({
    int? subjectId,
    int? childId,
    int? pathId,
    int? termId,
  }) {
    return AddAndDeleteSubjectInputs(
      subjectId: subjectId ?? this.subjectId,
      childId: childId ?? this.childId,
      pathId: pathId ?? this.pathId,
      termId: termId ?? this.termId,
    );
  }
}
